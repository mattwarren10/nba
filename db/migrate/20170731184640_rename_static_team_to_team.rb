class RenameStaticTeamToTeam < ActiveRecord::Migration[5.1]
  def change
  	rename_table :static_teams, :teams
  end
end
