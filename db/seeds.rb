u = User.new
u.email="user@example.com"
u.password=u.password_confirmation="Password1"
u.save!
u.roles=['admin', 'manager', 'translator', 'analyst', 'user'] 
u.save!

a = AdminUser.new
a.email="admin@example.com"
a.password=u.password_confirmation="Password1"
a.save!

p = Project.new
p.name = "Test Project" 
p.description = "This is only a test!"
p.save!
