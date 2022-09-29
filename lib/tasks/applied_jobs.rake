# namespace :applied_jobs do
#   desc 'Create applied job viecdayroi application'
#   task create_applied_jobs: :environment do
#     AppliedJob.destroy_all
#     employees = User.where(user_type: 'Employee')
#     users = User.where(user_type: 'Employer')
#     jobs = Job.take(Job.count - 10)
#     users.each do |user|
#       Job.all.each do |job|
#         employees.each do |employee|
#           AppliedJob.create(
#             user_id: user.id,
#             job_id: job.id,
#             employee_id: employee.id
#           )
#         end
#       end
#     end
#   end
# end
