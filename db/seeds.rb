user_email = "user@example.com"
user_password = "Password1"
puts "Creating user with email #{user_email} and password #{user_password}..."
u = User.new
u.email=user_email
u.password=u.password_confirmation=user_password
u.save!
u.roles=['admin', 'manager', 'translator', 'analyst', 'user'] 
u.save!

admin_email = "admin@example.com"
admin_password = "Password1"
puts "Creating admin user with email #{admin_email} and password #{admin_password}..."
a = AdminUser.new
a.email=admin_email
a.password=u.password_confirmation=admin_password
a.save!

project_name = "Test Project"
project_description = "This is only a test!"
puts "Creating project with name #{project_name} and description #{project_description}..."
p = Project.new
p.name = project_name 
p.description = project_description
p.save!

puts "Creating user project..."
up = UserProject.new
up.user_id = u.id
up.project_id = p.id
up.save!

i = p.instruments.create!(title: "Long Test Instrument",
  language: "en",
  alignment: "left"
)
p "Created #{i.title}"
2000.times do |q_n|
  question_type = Settings.question_types.sample
  question = i.questions.create!(text: "Question #{q_n}",
    question_identifier: "q_#{q_n}",
    question_type: question_type,
    number_in_instrument: "#{q_n+1}"
  )
  if Settings.question_with_options.include? question_type
    5.times do |o_n|
      question.options.create!(text: "Option #{o_n}") 
    end
  end
end
