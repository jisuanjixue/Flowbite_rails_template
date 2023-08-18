# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
user = User.create!(username: "bobo", email: "20668323@qq.com", password: "abcd123", password_confirmation: "abcd123", remember_me: true)
Post.create([{ title: "Star Wars", description: "aaaa", user_id: user.id }])
#   Character.create(name: "Luke", movie: movies.first)
