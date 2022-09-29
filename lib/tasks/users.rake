namespace :users do
  desc 'Create employee and employer user'
  task create_users: :environment do
    User.create(
      user_type: 'Employer',
      email: 'nguyenvanhuan243@gmail.com',
      password: Digest::MD5.hexdigest('123456'),
      confirm_password: Digest::MD5.hexdigest('123456')
    )
  end
end
