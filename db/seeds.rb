# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# User.create!(
#     name: 'Admin',
#   email: 'admin@example.com',
#   password: 'password',
#   password_confirmation: 'password',
#   admin: true,
#   status: true
# )

# # Create Regular Users
# 5.times do |i|
#   User.create!(
#     name: "User #{i + 1}",
#     email: "user#{i + 1}@example.com",
#     password: 'password',
#     password_confirmation: 'password',
#     admin: false,
#     status: true
#   )
# end


Item.create!(
  name: 'Example Item',
  description: 'This is an example item',
  category: 'Example Category',
  image: 'example.jpg',
  user_id: 1,
  collection_id: 1,
  tags: ['example', 'seed']
)


