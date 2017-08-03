# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create(last_name: "Warren", first_name: "Matt", username: "mattwarren", email: "mwarren@harding.edu", password: "weeboo", password_confirmation: "weeboo")

BasicUser.create(last_name: "Mardanzai", first_name: "Louis", username: "louismardanzai", email: "malwarr@indiana.edu", password: "tarbooz", password_confirmation: "tarbooz")
BasicUser.create(last_name: "Jones", first_name: "Alex", username: "alexjones", email: "alexjones@gmail.com", password: "rockets", password_confirmation: "rockets")


League.create(name: "Afghanistan National League", commissioner: "louismardanzai", headquarters: "Kabul, AF", inaugural_season: "2008-09", number_of_teams: 30, abbreviation: "ANL")
League.create(name: "World Basketball League", commissioner: "alexjones", headquarters: "Indianapolis, IN", inaugural_season: "2017-18", number_of_teams: 30, abbreviation: "WBL")

Player.create(last_name: "Warren", first_name: "Matt", jersey_number: "33", height: 200, weight: 85, birth_date: DateTime.now	- 25.years, before_nba: "Indiana", is_rookie: true, position: "PG", which_pick: "2010 / Round: 1 / Pick: 1st overall", years_pro: 0, status: 0, from_city: "Bloomington, Indiana", wiki_link: "Matt_Warren", image_link: "//upload.wikimedia.org/Matt_Warren") 

# Stat.create(season: "2017-18", team: "Indiana", games_played: 82, games_started: 75, minutes_per_game: 35.4, field_goal_percent: 0.482, three_point_percent: 0.410, free_throw_percent: 0.920, rebounds_per_game: 6.2, assists_per_game: 11.4, steals_per_game: 2.1, blocks_per_game: 1.1, points_per_game: 26.2)


