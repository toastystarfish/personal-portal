# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'datum'

User.create({
  first_name: ENV['LOCAL_DEV_FIRST_NAME'],
  last_name:  ENV['LOCAL_DEV_LAST_NAME'],
  email:      ENV['LOCAL_DEV_EMAIL'],
  password:   ENV['LOCAL_DEV_PASSWORD'],
  roles_mask: User.roles[:developer] | User.roles[:admin]
})

__import :simpsons
