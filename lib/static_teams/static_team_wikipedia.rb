require 'rubygems'
require 'open-uri'
require 'nokogiri'

module StaticTeamWikipedia
  def self.retrieve_from_wikipedia
    wiki_url = 'https://en.wikipedia.org/wiki/Wikipedia:WikiProject_National_Basketball_Association/National_Basketball_Association_team_abbreviations'
    nba_wikipedia_page = Nokogiri::HTML(open(wiki_url))
    table = nba_wikipedia_page.css("tr").text 
    convert_to_arr(table)
  end

  def self.convert_to_arr data
    arr = []        
    arr = data.split("\n")
    4.times { arr.shift }
    arr.delete("")
    isolate_strings(arr)
  end

  def self.isolate_strings arr    
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
    create_hash(team_cities, team_names, team_abbr)
  end

  def self.create_hash team_cities, team_names, team_abbr
    teams = []
    30.times do |i|
      teams_hash = {}  
      teams_hash[:city] = team_cities[i]
      teams_hash[:name] = team_names[i]
      teams_hash[:abbreviation] = team_abbr[i]
      teams.push(teams_hash)
    end
    teams
  end
end