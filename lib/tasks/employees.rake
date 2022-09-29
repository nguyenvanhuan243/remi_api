# namespace :employees do
#   desc 'Create sample employees for viecdayroi application'
#   task create_employees: :environment do
#     def create_data_list(text)
#       [1, 2, 3, 4, 5, 6].map { |n| text + n.to_s }
#     end
#     Employee.create!(
#       user_id: User.first.id,
#       skills: create_data_list('Skill_1 Objectives Objectives Objectives Objectives'),
#       degree: create_data_list('Degree Objectives Objectives Objectives Objectives'),
#       objectives: create_data_list('Objectives Objectives Objectives Objectives Objectives'),
#       favorite_languages: create_data_list('Favorite languages Objectives Objectives Objectives'),
#       office_information: create_data_list('Office Information Objectives Objectives Objectives'),
#       working_experiences: create_data_list('Working Experiences Objectives Objectives')
#     )
#     Employee.create!(
#       user_id: User.third.id,
#       skills: create_data_list('Skill_2'),
#       degree: create_data_list('Degree Objectives Objectives Objectives Objectives'),
#       objectives: create_data_list('Objectives Objectives Objectives Objectives Objectives'),
#       favorite_languages: create_data_list('Favorite languages Objectives Objectives Objectives'),
#       office_information: create_data_list('Office Information Objectives Objectives Objectives'),
#       working_experiences: create_data_list('Working Experiences Objectives Objectives')
#     )
#     Employee.create!(
#       user_id: User.last.id,
#       skills: create_data_list('Skill_3'),
#       degree: create_data_list('Degree Objectives Objectives Objectives Objectives'),
#       objectives: create_data_list('Objectives Objectives Objectives Objectives Objectives'),
#       favorite_languages: create_data_list('Favorite languages Objectives Objectives Objectives'),
#       office_information: create_data_list('Office Information Objectives Objectives Objectives'),
#       working_experiences: create_data_list('Working Experiences Objectives Objectives')
#     )
#   end
# end 
