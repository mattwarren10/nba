require 'fileutils'
require 'colorize'

namespace :player do  
  namespace :active do 
    desc 'creating active players'
    task create: :environment do
      players_created_count = 0
      teams_looped_through = 0
      nba = League.find(1)
      league = ActivePlayer::Attr.get

      # create each player and place them on the correct team
      league.each do |team_abbr, roster|
        roster.each do |player_hash|
          team = Team.find_by(abbreviation: team_abbr)
          player = Player.create(
            last_name: player_hash[:last_name],
            first_name: player_hash[:first_name],
            jersey_number: player_hash[:jersey_number],
            height: player_hash[:height],
            weight: player_hash[:weight],
            before_nba: player_hash[:before_nba],
            is_rookie: player_hash[:is_rookie],
            position: player_hash[:position],
            birth_date: player_hash[:birth_date],
            which_pick: player_hash[:which_pick],
            years_pro: player_hash[:years_pro],
            wiki_link: player_hash[:wiki_link],
            image_link: player_hash[:image_link],
            from_city: player_hash[:from_city],
            status: 0
          )
          puts "Adding #{player.last_name} to #{nba.abbreviation}...".yellow
          nba.players.push(player)
          unless LeagueTeam.where(team_id: team.id).exists?
            puts "Adding #{team.abbreviation} to #{nba.abbreviation}...".yellow
            nba.teams.push(team)
          end
          league_player = LeaguePlayer.where(league_id: nba.id, player_id: player.id).first
          league_team = LeagueTeam.where(league_id: nba.id, team_id: team.id).first
          if player.valid?        
            players_created_count += 1
            puts "#{player.last_name}, #{player.first_name} (id: #{player.id}) has been created."
            puts "==> #{players_created_count} players created"            
            league_team.league_players.push(league_player)
                         
          else
            puts "Failure: tried to create player: #{player}".red
            puts "  ==> #{player.errors.full_messages.red}".red.bold
            break player
          end          

          # create stats for a player's single season
          stats_created_count = 0
          player_hash[:regular_season_stats].each do |s|              
            if player.is_rookie
              level = 1
            else 
              level = 0
            end
            stat = Stat.create(
              league_player_id: league_player.id,
              league_team_id: league_team.id,
              season: s[0],
              team: s[1],
              games_played: BigDecimal.new(s[2]),
              games_started: BigDecimal.new(s[3]),
              minutes_per_game: BigDecimal.new(s[4]),
              field_goal_percent: BigDecimal.new(s[5]),
              three_point_percent: BigDecimal.new(s[6]),
              free_throw_percent: BigDecimal.new(s[7]),
              rebounds_per_game: BigDecimal.new(s[8]),
              assists_per_game: BigDecimal.new(s[9]),
              steals_per_game: BigDecimal.new(s[10]),
              blocks_per_game: BigDecimal.new(s[11]),
              points_per_game: BigDecimal.new(s[12]),
              level: level,
              category: 0
            )
            if stat.valid?
              stats_created_count += 1
              puts "==> #{stat.season}, (id: #{stat.id}) has been created.".light_blue              
              puts "==> #{stats_created_count} stats created for #{player.last_name} so far".light_blue                                     
            else
              puts "Failure: tried to create stat: #{stat}".red
              puts "==> #{stat.errors.full_messages.red}".red.bold
              break stat
            end
          end                
        end        
      end
      puts "#{players_created_count} total active players created for the #{nba.name}".green.bold
    end
  end
end

namespace :player do
  namespace :active do
    desc 'downloads active player wikis from wikipedia.org'
    task wiki: :environment do
      player_wikis_count = 0
      teams_looped_through = 0
      league = ActivePlayer::Attr.get
      league.each do |team_abbr, roster|        
        roster.each do |player|          
          link_src = open("https://en.wikipedia.org/wiki/#{player[:link]}")
          link_dest = "vendor/active_player_wiki/#{team_abbr.downcase}/#{player[:link]}.html"          
          IO.copy_stream(link_src, link_dest)
          if File.file?(link_dest)
            player_wikis_count += 1
            puts "#{player_wikis_count}: #{player[:last_name]}'s wiki has been stored at".green
            puts "==>#{link_dest}"
          else
            puts "Failed to store #{player[:last_name]}'s wiki page".red.bold
            break player
          end                  
        teams_looped_through += 1
        puts "#{teams_looped_through} teams looped through".light_blue
        end
      puts "#{player_wikis_count} player wikis downloaded".bold
      end
    end
  end
end

namespace :player do
  namespace :retired do
    desc 'creating retired players'
    task create: :environment do
      players_created_count = 0
      nba = League.find(1)
      retired_players = RetiredPlayer::Attr.get
      retired_players.each do |r|
        player = Player.create(
          last_name: r[:last_name],
          first_name: r[:first_name],
          jersey_number: r[:jersey_number],
          height: r[:height],
          weight: r[:weight],
          before_nba: r[:before_nba],
          is_rookie: r[:is_rookie],
          position: r[:position],
          birth_date: r[:birth_date],
          which_pick: r[:which_pick],
          years_pro: r[:years_pro],
          wiki_link: r[:wiki_link],
          image_link: r[:image_link],
          from_city: r[:from_city],
          status: 1
        )
        puts "Adding #{player.last_name} to #{nba.abbreviation}...".yellow
        nba.players.push(player)        
        league_player = LeaguePlayer.where(league_id: nba.id, player_id: player.id).first        
        if player.valid?        
          players_created_count += 1
          puts "#{player.last_name}, #{player.first_name} (id: #{player.id}) has been created."
          puts "==> #{players_created_count} players created"                      
                       
        else
          puts "Failure: tried to create player: #{player}".red
          puts "  ==> #{player.errors.full_messages.red}".red.bold
          break player
        end
        stats_created_count = 0
        player_hash[:regular_season_stats].each do |s|                       
          stat = Stat.create(
            league_player_id: league_player.id,            
            season: s[0],
            team: s[1],
            games_played: BigDecimal.new(s[2]),
            games_started: BigDecimal.new(s[3]),
            minutes_per_game: BigDecimal.new(s[4]),
            field_goal_percent: BigDecimal.new(s[5]),
            three_point_percent: BigDecimal.new(s[6]),
            free_throw_percent: BigDecimal.new(s[7]),
            rebounds_per_game: BigDecimal.new(s[8]),
            assists_per_game: BigDecimal.new(s[9]),
            steals_per_game: BigDecimal.new(s[10]),
            blocks_per_game: BigDecimal.new(s[11]),
            points_per_game: BigDecimal.new(s[12]),
            level: level,
            category: 0
          )
          if stat.valid?
            stats_created_count += 1
            puts "==> #{stat.season}, (id: #{stat.id}) has been created.".light_blue              
            puts "==> #{stats_created_count} stats created for #{player.last_name} so far".light_blue                                     
          else
            puts "Failure: tried to create stat: #{stat}".red
            puts "==> #{stat.errors.full_messages.red}".red.bold
            break stat
          end
        end
      end
    end
  end
end

namespace :player do
  namespace :retired do
    desc 'downloads retired player wikis from wikipedia.org'
    task wiki: :environment do
      player_wikis_count = 0
      players = RetiredPlayer::WikiList.separate_names_and_links
      players.each do |player|
        link_src = open("https://en.wikipedia.org/wiki/#{player[:wiki_link]}")
          link_dest = "vendor/retired_player_wiki/#{player[:wiki_link]}.html"
          IO.copy_stream(link_src, link_dest)
          if File.file?(link_dest)
            player_wikis_count += 1
            puts "#{player_wikis_count}: #{player[:last_name]}'s wiki has been stored at".green
            puts "==>#{link_dest}"
          else
            puts "Failed to store #{player[:last_name]}'s wiki page".red.bold
            break player
          end   
      end
      puts "#{player_wikis_count} player wikis downloaded".bold
    end
  end
end



