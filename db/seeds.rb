# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Admin.find_or_create_by!(email: "admin1@example.com") do |admin|
  admin.username = "admin1"
  admin.password = "MW4ZKS4hV5L@tYV#baji&5f*"
  admin.password_confirmation = "MW4ZKS4hV5L@tYV#baji&5f*"
end

Admin.find_or_create_by!(email: "admin2@example.com") do |admin|
  admin.username = "admin2"
  admin.password = "MW4ZKS4hV5L@tYV#baji&5f*"
  admin.password_confirmation = "MW4ZKS4hV5L@tYV#baji&5f*"
end

Customer.find_or_create_by!(email: "customer1@example.com") do |customer|
  customer.password = "6cMVQbheq9&R9C#SoB4$nY2j"
  customer.password_confirmation = "6cMVQbheq9&R9C#SoB4$nY2j"
end

Customer.find_or_create_by!(email: "customer2@example.com") do |customer|
  customer.password = "6cMVQbheq9&R9C#SoB4$nY2j"
  customer.password_confirmation = "6cMVQbheq9&R9C#SoB4$nY2j"
end
