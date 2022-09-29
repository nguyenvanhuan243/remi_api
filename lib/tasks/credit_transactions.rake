# namespace :credit_transactions do
#     desc 'Create employee and employer user'
#     task create_credit_transactions: :environment do
#         CreditTransaction.delete_all
#         user = User.find_by_id(1)
#         credit_amount = user.credit_amounts.first
#         transaction = credit_amount.credit_transactions
#         balance_list = [
#             1000,
#             2000,
#             3000,
#             4000,
#             5000,
#             6000,
#             7000,
#             8000,
#             9000,
#             10000
#         ]
#         5.times do
#             balance_list.each do |balance_item|
#                 transaction.create(
#                     balance: balance_item * 1000000,
#                     status: 'done'
#                 )
#             end
#         end
#     end
# end
  