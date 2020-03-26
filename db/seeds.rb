# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(name: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true)
User.create(name: 'saeki', email: 'masaakisaeki@gmail.com', password: 'hogehoge', password_confirmation: 'hogehoge', admin: true)

Skill.create(name: 'Excel', category: 0)
Skill.create(name: 'Word', category: 0)
Skill.create(name: 'PHP', category: 1)
Skill.create(name: 'Ruby', category: 1)
Skill.create(name: 'Python', category: 1)
Skill.create(name: 'HTML', category: 1)
Skill.create(name: 'CSS', category: 1)
Skill.create(name: 'イラレ', category: 2)
Skill.create(name: 'XD', category: 2)
Skill.create(name: 'フォトショ', category: 2)