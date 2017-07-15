require 'rubygems'
require 'open-uri'
require 'nokogiri'
require_relative 'static_team_nba_com'

WIKI_URL = 'https://en.wikipedia.org/wiki/Wikipedia:WikiProject_National_Basketball_Association/National_Basketball_Association_team_abbreviations'
nba_wikipedia_page = Nokogiri::HTML(open(WIKI_URL))
table = nba_wikipedia_page.css("tr").text	
arr = []				
arr = table.split("\n")
4.times { arr.shift }
arr.delete("")

teams = []
team_names = []
team_cities = []
team_abbr = []
arr.each_with_index do |str, i|
  if i.odd?
    team_names.push(str.split.last)
    team_cities.push(str[0..str.rindex(' ')].rstrip)
  end
end
arr.each_with_index do |abbr, i|
  if i.even?
    team_abbr.push(abbr)
  end
end

30.times do |i|
  teams_hash = {}  
  teams_hash[:city] = team_cities[i]
  teams_hash[:name] = team_names[i]
  teams_hash[:abbreviation] = team_abbr[i]
  teams.push(teams_hash)
end

p teams