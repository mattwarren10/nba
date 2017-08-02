# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


BasicUser.create(last_name: "Mardanzai", first_name: "Louis", username: "louismardanzai", email: "malwarr@indiana.edu", password: "tarbooz", password_confirmation: "tarbooz")
BasicUser.create(last_name: "Jones", first_name: "Alex", username: "alexjones", email: "alexjones@gmail.com", password: "rockets", password_confirmation: "rockets")


League.create(name: "Afghanistan League", commissioner: "Bubba Jan", headquarters: "Kabul, AF", inaugural_season: "2008-09", number_of_teams: 30, abbreviation: "AFG")
League.create(name: "World Basketball League", commissioner: "louismardanzai", headquarters: "Indianapolis, IN", inaugural_season: "2017-18", number_of_teams: 30, abbreviation: "WBL")