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
User.destroy_all
Game.destroy_all
Genre.destroy_all
Platform.destroy_all
Company.destroy_all

# Create random users using Faker
puts "Seeding users..."
# Create 1 admin
User.create(username: "admin", email: "admin@mail.com", password: "123456", role: "admin")
# Create 10 contributors
10.times do
  contributor_data = {
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.safe_email,
    password: Faker::Internet.password(min_length: 6)
  }
  new_user = User.create(contributor_data)
  puts "User not created.\nErrors: #{new_user.errors.full_messages}" unless new_user.save
end

# Create all the companies from JSON file
puts "Seeding companies..."
companies = JSON.parse(File.read("data/companies.json"), symbolize_names: true)
companies.each do |company|
  company_data = company.slice(:name, :description, :start_date, :country)
  new_company = Company.new(company_data)

  io_path = company[:cover][:io_path]
  filename = company[:cover][:filename]
  new_company.cover.attach(io: File.open(io_path), filename: filename)

  puts "Company not created.\nErrors: #{new_company.errors.full_messages}" unless new_company.save
end

# Create all the platforms from JSON file
puts "Seeding platforms..."
platforms = JSON.parse(File.read("data/platforms.json"), symbolize_names: true)
platforms.each do |platform_data|
  new_platform = Platform.new(platform_data)
  puts "Platform not created.\nErrors: #{new_platform.errors.full_messages}" unless new_platform.save
end

# Create all the genres from JSON file
puts "Seeding genres..."
genres = JSON.parse(File.read("data/genres.json"), symbolize_names: true)
genres.each do |genre|
  new_genre = Genre.new(name: genre)
  puts "Genre not created.\nErrors: #{new_genre.errors.full_messages}" unless new_genre.save
end

# Create all the games from JSON file
puts "Seeding games..."
games = JSON.parse(File.read("data/games.json"), symbolize_names: true)
games.each do |game|
  game_data = game.slice(:name, :summary, :release_date, :category, :rating)
  new_game = Game.create(game_data)

  parent = Game.find_by(name: game[:parent])
  new_game.parent = parent

  io_path = game[:cover][:io_path]
  filename = game[:cover][:filename]
  new_game.cover.attach(io: File.open(io_path), filename: filename)
  puts "Game not created.\nErrors: #{new_game.errors.full_messages}" unless new_game.save
  new_game = Game.last

  game[:genres].each do |genre_name|
    genre = Genre.find_by(name: genre_name)
    new_game.genres << genre
  end

  game[:platforms].each do |platform_data|
    platform_name = platform_data[:name]
    platform = Platform.find_by(name: platform_name)
    new_game.platforms << platform
  end

  game[:involved_companies].each do |involved_company|
    involved_company_data = {
      game: new_game,
      company: Company.find_by(name: involved_company[:name]),
      developer: involved_company[:developer],
      publisher: involved_company[:publisher]
    }
    new_involved_company = InvolvedCompany.new(involved_company_data)
    puts "Involved company not created.\nErrors: #{new_involved_company.errors.full_messages}" unless new_involved_company.save
  end
end

# Create random critics using Faker
puts "Seeding critics..."
# For each game and company, create between 1 and 3 critics from random users
users = User.all
collection = Game.all + Company.all
collection.each do |item|
  rand(1..3).times do
    critic_data = {
      title: Faker::Lorem.sentence(word_count: 1, random_words_to_add: 3),
      body: Faker::Lorem.paragraph,
      user: users.sample,
      criticable: item
    }
    new_critic = Critic.new(critic_data)

    puts "Critic not created.\nErrors: #{new_critic.errors.full_messages}" unless new_critic.save
  end
end
puts "Finish seeding"
