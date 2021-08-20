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
  new_user = User.create(contributor_data)
  puts "User not created.\nErrors: #{new_user.errors.full_messages}" unless new_user.save
end

# Create all the companies from JSON file
puts "Seeding companies..."
companies = JSON.parse(File.read("data/companies.json"), symbolize_names: true)
companies.each do |company_data|
  new_company = Company.new(company_data)
  puts "Company not created.\nErrors: #{new_company.errors.full_messages}" unless new_company.save
end

# Create all the platforms from JSON file
puts "Seeding platforms..."
platforms = JSON.parse(File.read("data/platforms.json"), symbolize_names: true)
platforms.each do |platform_data|
  new_platform = Platform.new(platform_data)
  puts "Platform not created.\nErrors: #{new_platform.errors.full_messages}" unless new_platform.save
end
puts "Finish seeding"
