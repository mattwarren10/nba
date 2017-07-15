namespace :static_team do
  desc "TODO"
  task create: :environment do
    @teams = StaticTeamAttributes.get_teams
  	@teams.each do |team|
      StaticTeam.create!(
        city: team[:city],
        name: team[:name],
        abbreviation: team[:abbreviation],
        nba_com: team[:nba_com]
      )
    end
  end

end
