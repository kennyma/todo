# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if !User.exists?(:email => "scott@railsnewbie.com")
  puts "* Creating myself!"
  user = User.new
  user.email = "scott@railsnewbie.com"
  user.save!

  puts "* Creating 'My Todo List'"
  list = TodoList.new
  list.user = user
  list.text = "My Todo List"
  list.save!
end

