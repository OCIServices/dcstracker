# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'jonathon.hoaglin@datcard.com')

Umbrella.create(name: 'Unsorted')
Customer.create(umbrella: Umbrella.first, name: 'DatCard')
Device.create(customer:Customer.first)
Dropdown.create(name: 'test category')
Dropdown.create(name: 'Closed')
Dropdown.create(name: 'Out of Service')
Ticket.create(device:Device.first, category: Dropdown.first, ticket_text:"this is an unassigned open ticket")
Ticket.create(device:Device.first, category: Dropdown.first, priority: true, ticket_text:"this is a priority open ticket")
Ticket.create(device:Device.first, category: Dropdown.first, status: Dropdown.second, ticket_text:"this is a closed ticket")
Ticket.create(device:Device.first, category: Dropdown.first, status: Dropdown.third, ticket_text:"this is an out of service ticket")

Ticket.create(device:Device.first, category: Dropdown.first, assigned_to: User.first, ticket_text:"this is my open ticket")