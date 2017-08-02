louis = BasicUser.create(last_name: "Mardanzai", first_name: "Louis", username: "louismardanzai", email: "malwarr@indiana.edu", password: "tarbooz", password_confirmation: "tarbooz")
alex = BasicUser.create(last_name: "Jones", first_name: "Alex", username: "alexjones", email: "alexjones@gmail.com", password: "rockets", password_confirmation: "rockets")


afg = League.create(name: "Afghanistan League", commissioner: "Bubba Jan", headquarters: "Kabul, AF", inaugural_season: "2008-09", number_of_teams: 30, abbreviation: "AFG")
wbl = League.create(name: "World Basketball League", commissioner: "louismardanzai", headquarters: "Indianapolis, IN", inaugural_season: "2017-18", number_of_teams: 30, abbreviation: "WBL")

