# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ga1 = Game.create(name: "game1",
              summary: "Este es el game 1",
              category: 0,
              release_date: '2010-02-05',
              rating: 5.9)
ga1.cover.attach(io: File.open('app/assets/images/games/card_barbie.jpg'), filename: 'card.jpg')
ga1.save

ga2 = Game.create(name: "game2",
  summary: "game 2",
  category: "main_game",
  release_date: '2010-02-03',
  rating: 5.9)
ga2.cover.attach(io: File.open('app/assets/images/games/jirafe.jpg'), filename: 'card2.jpg')
ga2.save

ga3 = Game.create(name: "game3",
  summary: "game 3",
  category: "main_game",
  release_date: '2010-02-03',
  rating: 5.9)
ga3.cover.attach(io: File.open('app/assets/images/games/jirafe.jpg'), filename: 'card2.jpg')
ga3.save

ga4 = Game.new(name: "game4",
  summary: "game 4",
  category: "main_game",
  release_date: '2010-02-03',
  rating: 5.9,
  parent_id: 1)
ga4.cover.attach(io: File.open('app/assets/images/games/jirafe.jpg'), filename: 'card2.jpg')
ga4.save