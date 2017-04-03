# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create({
  first_name: ENV['LOCAL_DEV_FIRST_NAME'],
  last_name:  ENV['LOCAL_DEV_LAST_NAME'],
  email:      ENV['LOCAL_DEV_EMAIL'],
  password:   ENV['LOCAL_DEV_PASSWORD'],
  roles_mask: User.roles[:developer]
})
User.create({
  first_name: 'Homer',
  last_name: 'Simpson',
  roles_mask: User.roles[:owner],
  email:      'homer@springfield.com',
  password:   'p@ssw0rd'
})
User.create({
  first_name: 'Marge',
  last_name: 'Simpson',
  roles_mask: User.roles[:admin],
  email:      'marge@springfield.com',
  password:   'p@ssw0rd'
})
User.create({
  first_name: 'Lisa',
  last_name: 'Simpson',
  roles_mask: User.roles[:developer],
  email:      'lisa@springfield.com',
  password:   'p@ssw0rd'
})
User.create({
  first_name: 'Bart',
  last_name: 'Simpson',
  email:      'bart@springfield.com',
  password:   'p@ssw0rd'
})
User.create({
  first_name: 'Maggie',
  last_name: 'Simpson',
  email:      'maggie@springfield.com',
  password:   'p@ssw0rd'
})
User.create({
  first_name: 'Ned',
  last_name: 'Flanders',
  email:      'ned@springfield.com',
  password:   'p@ssw0rd',
  roles_mask: User.roles[:admin]
})
User.create({
  first_name: 'John',
  last_name: 'Frink',
  email:      'frink@springfield.com',
  password:   'p@ssw0rd',
  roles_mask: User.roles[:developer]
})
User.create({
  first_name: 'Apu',
  last_name: 'Nahasapeemapetilon',
  email:      'apu@springfield.com',
  password:   'p@ssw0rd'
})
User.create({
  first_name: 'Troy',
  last_name: 'McClure',
  email:      'troymcclure@springfield.com',
  password:   'p@ssw0rd'
})
User.create({
  first_name: 'Lenny',
  last_name: 'Leonard',
  email:      'lenny@springfield.com',
  password:   'p@ssw0rd'
})
User.create({
  first_name: 'Carl',
  last_name: 'Carlson',
  email:      'carl@springfield.com',
  password:   'p@ssw0rd'
})
User.create({
  first_name: 'Nelson',
  last_name: 'Muntz',
  email:      'nelson@springfield.com',
  password:   'p@ssw0rd'
})
