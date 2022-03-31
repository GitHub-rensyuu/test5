# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.create!(
  email: "a@a",
  name: "a" * 3,
  password: "a" * 6
)

User.create!(
  email: "b@b",
  name: "b" * 3,
  password: "b" * 6
)

# 5.times do |n|
#     User.create!(
#       email: "test#{n + 1}@test.com",
#       name: "テスト太郎#{n + 1}",
#       password: "#{n + 1}" * 6
#     )
#   end