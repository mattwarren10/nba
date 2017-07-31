require 'colorize'

namespace :teams do
  desc "creates a record for each nba team from team modules"
  task create: :environment do
    teams = Team::Attr.get
    teams_created = 0
    teams.each do |team|
      t = StaticTeam.create(
        city: team[:city],
        name: team[:name],
        abbreviation: team[:abbreviation],        
      )
      if t.valid?        
        puts "#{t.abbreviation} (id: #{t.id}) has been created.".green        
        teams_created += 1
      else
        puts "Failure: tried to create: #{t}".red.bold
        puts "     ==> #{t.errors.full_messages.red}"
        break
      end
    end
    puts "#{teams_created} StaticTeam database records created.".bold
  end


  namespace :download do
    desc "downloads team logos from sportslogos.net"
    task logo: :environment do
      nba_team_logos_created = 0
      logo_srcs = Team::Logo.src
      @teams = StaticTeam.all
      logo_srcs.each_with_index do |src, i| 
        img_src = open(src)
        img_dest = "app/assets/images/nba_team_logos/#{@teams[i].abbreviation}.gif"
        IO.copy_stream(img_src, img_dest)
        if File.file? img_dest
          puts "#{@teams[i].city} #{@teams[i].name}'s gif image has been stored at #{img_dest}".green
          nba_team_logos_created += 1
        else
          puts "Failed to store #{@teams[i].city} #{@teams[i].name}'s gif".red.bold
          break
        end
      end
      puts "#{nba_team_logos_created} team logos have been downloaded to the assets directory".bold
    end

    desc 'downloads team rosters from wikipedia.org'
    task roster: :environment do
      nba_rosters_created = 0
      roster_urls = Team::Roster.urls
      @teams = StaticTeam.all
      roster_urls.each_with_index do |src, i|
        page_src = open(src)
        page_dest = "vendor/rosters/#{@teams[i].abbreviation.downcase}.html"
        IO.copy_stream(page_src, page_dest)
        if File.file? page_dest
          puts "#{@teams[i].abbreviation}'s roster downloaded to #{page_dest}".green
          nba_rosters_created += 1
        else
          puts "Failed to download #{@teams[i].abbreviation}'s roster".red.bold
          break
        end
      end
      puts "#{nba_rosters_created} team rosters have been downloaded to vender directory".bold
    end
  end

end
