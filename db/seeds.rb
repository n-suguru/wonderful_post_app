# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find_or_create_by!(email: "1@test.com") do |_user|
  _user.password = 'test1234'
end

article_owned_user = user.articles.find_or_create_by!(title: "No.1") do |article|
  article.content = "example"
end

article_owned_user.tags.create!(name: 'sample')
