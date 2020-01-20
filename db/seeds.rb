# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = "supersecret"

Idea.destroy_all
User.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!(:ideas)
ActiveRecord::Base.connection.reset_pk_sequence!(:users)


super_user = User.create( 
  first_name: "Jon", 
  last_name: "Snow", 
  email: "js@winterfell.gov", 
  password: PASSWORD
)
puts Cowsay.say("Admin login with #{super_user.email} and password of '#{PASSWORD}'", :cow)

Idea.insert_all(
  20.times.map do
    {
      title: Faker::Quote.yoda,
      description: Faker::GreekPhilosophers.quote,
      created_at: Faker::Date.backward(days:365 * 5),
      updated_at: Faker::Date.backward(days:365 * 3),
      user_id: super_user.id
    }
  end
)

puts Cowsay.say("Generated #{Idea.count} ideas using Faker.", :frogs)
