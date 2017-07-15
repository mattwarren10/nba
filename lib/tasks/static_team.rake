namespace :static_team do
  desc "creates a record for each nba team from static_team modules"
  task create: :environment do
    @teams = StaticTeamAttributes.get_teams
    nba_teams_created_counter = 0
    @teams.each do |team|
      StaticTeam.create(
        city: team[:city],
        name: team[:name],
        abbreviation: team[:abbreviation],
        nba_com: team[:nba_com]
      )
      nba_teams_created_counter += 1
    end
    puts "#{nba_teams_created_counter} StaticTeam database records created"
  end
end
