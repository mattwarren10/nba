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

  desc "downloads team logos from nba.com"
  task get_logos: :environment do
    nba_team_logos_created = 0
    @teams = StaticTeam.all
    @teams.each do |team| 
      img = open("http://i.cdn.turner.com/nba/nba/assets/logos/teams/primary/web/#{team.abbreviation}.svg")
      IO.copy_stream(img, "../../app/assets/images/nba_team_logos/#{team.abbreviation}.svg")
      nba_team_logos += 1
    end
    puts "#{nba_team_logos} team logos have been downloaded to the assets directory"
  end
end

