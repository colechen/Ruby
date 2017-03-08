# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create(:name => "Aaron", :email => "1@abc.com")
u2 = User.create(:name => "Tony", :email => "2@abc.com")
u3 = User.create(:name => "Candy", :email => "3@abc.com")
u4 = User.create(:name => "Cole", :email => "4@abc.com")
u5 = User.create(:name => "Amber", :email => "5@abc.com")

r1 = Role.create(:name => "First Line Manager")
r2 = Role.create(:name => "Developer")
r3 = Role.create(:name => "Project Manager")
r4 = Role.create(:name => "Test Lead")
r5 = Role.create(:name => "Test Support Engineer")
r6 = Role.create(:name => "File Handler")

p1 = Project.create(:name => "ProjectA")
p2 = Project.create(:name => "ProjectB")


u1.roles << [r2, r4, r5, r6]
u2.roles << [r3]
u3.roles << [r1]
u4.roles << [r2, r4, r5]
u5.roles << [r5, r6]

# Assignments for ProjactA
Assignment.create(:project_id => p1.id, :user_id => u1.id, :role_id => r4.id)
Assignment.create(:project_id => p1.id, :user_id => u2.id, :role_id => r3.id)
Assignment.create(:project_id => p1.id, :user_id => u5.id, :role_id => r5.id)
Assignment.create(:project_id => p1.id, :user_id => u1.id, :role_id => r6.id)

# Assignments for ProjactB
Assignment.create(:project_id => p2.id, :user_id => u4.id, :role_id => r4.id)
Assignment.create(:project_id => p2.id, :user_id => u2.id, :role_id => r3.id)
Assignment.create(:project_id => p2.id, :user_id => u5.id, :role_id => r6.id)
Assignment.create(:project_id => p2.id, :user_id => u1.id, :role_id => r5.id)
