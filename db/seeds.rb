# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'json'

puts "Start seeding"
# Create random users using Faker
puts "Seeding users..."
# Create 1 admin
User.create(username: "admin", email: "admin@mail.com", role: "admin")

# Create 10 contributors
10.times do
  contributor_data = {
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.safe_email,
  }
  User.create(contributor_data)
end
puts "Finish seeding"
