class API::V1::Payments < API::V1::Base
  helpers API::V1::Helpers
  resource :payments do
    desc 'Get payment by access token',
         entity: API::Entities::V1::Payment
    params do
      use :authorization_token
    end
    get '' do
      user = authenticate_user!
      present user.payments.order(created_at: :desc), with: API::Entities::V1::Payment
    end

    # Get all deposit payments
    desc 'Get payment by access token',
         entity: API::Entities::V1::Payment
    params do
    end
    get 'all_deposit_payments' do
      present Payment.where(payment_type: 0).order(created_at: :desc),
              with: API::Entities::V1::Payment
    end

    # Get all withdrawn payments
    desc 'Get payment by access token',
         entity: API::Entities::V1::Payment
    params do
    end
    get 'all_withdrawn_payments' do
      present Payment.where(payment_type: 1).order(created_at: :desc),
              with: API::Entities::V1::Payment
    end

    # Create payment
    desc 'create deposit payment from web hook',
         entity: API::Entities::V1::Payment
    params do
      requires :from, type: String, desc: 'Crypto address'
      requires :to, type: String, desc: 'Crypto address'
      requires :value, type: Float, desc: 'Amount payment'
    end
    post '' do
      user = User.find_by(usdt_address: params[:to])
      payment = nil
      if user
        payment_by_transaction_hash = Payment.find_by(
          transaction_hash: params[:transactionHash]
        )
        unless payment_by_transaction_hash
          value = params[:value].to_f / 1_000_000_000_000_000_000
          payment = user.payments.create(
            from: params[:from],
            to: params[:to],
            value: value,
            payment_type: Payment.payment_types[:deposit],
            transaction_hash: params[:transactionHash],
            status: Payment.statuses[:network_confirmed]
          )
          usdt_asset = user.assets.find_by(currency: 'USDT')
          new_balance = usdt_asset.balance + value
          usdt_asset.update(balance: new_balance)
        end
      end
      present payment, with: API::Entities::V1::Payment
    end

    # Create payment
    desc 'create withdraw payment',
         entity: API::Entities::V1::Payment
    params do
      use :authorization_token
      requires :to, type: String, desc: 'Crypto address'
      requires :value, type: Float, desc: 'Amount payment'
    end
    post '/withdraw' do
      user = authenticate_user!

      if user.free_usdt_asset.to_f >= params[:value].to_f
        payment = user.payments.create(
          to: params[:to],
          value: params[:value],
          payment_type: Payment.payment_types[:withdrawn],
          status: Payment.statuses[:pending]
        )
        user.lock_balance_withdrawn(params[:value].to_f)
        begin
          UserMailer.notify_confirm_withdraw(user, payment).deliver_now
        rescue StandardError => e
          Sentry.capture_exception("EMAIL_VERIFICATION #{e}")
        end
      else
        error!('Your balance is not enough', 400)
      end
      present payment, with: API::Entities::V1::Payment
    end

    # Confirm withdraw payment from web hook
    desc 'Network confirmed payment',
         entity: API::Entities::V1::Payment
    params do
      requires :from, type: String, desc: 'Crypto address'
      requires :to, type: String, desc: 'Crypto address'
      requires :value, type: Float, desc: 'Amount payment'
    end
    post '/network_confirmed' do
      payment = Payment.find_by(
        to: params[:to],
        status: Payment.statuses[:approved],
        payment_type: Payment.payment_types[:withdrawn]
      )
      if payment
        payment.network_confirmed!
        user = payment.user
        asset = user.assets.find_by(currency: 'USDT')
        asset.balance -= payment.value.to_f
        asset.locked_balance = asset.locked_balance - payment.value.to_f
        asset.save!
      end
      present payment, with: API::Entities::V1::Payment
    rescue StandardError => e
      Sentry.capture_exception(e)
    end

    # Cancel payment
    desc 'Cancel payment',
         entity: API::Entities::V1::Payment
    params do
      use :authorization_token
    end
    post '/cancel_payment/:id' do
      user = authenticate_user!
      payment = Payment.pending.find_by(
        id: params[:id]
      )
      error!('Can not cancel this payment', 400) unless payment
      payment.cancel!
      user.release_locked_balance(payment.value)
      present payment, with: API::Entities::V1::Payment
    end
  end
end
