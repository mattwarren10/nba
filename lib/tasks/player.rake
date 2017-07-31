require 'fileutils'

namespace :player do

  desc "updates the records for each player"
  task update: :environment do
  end

  namespace :download do
    desc 'downloads player wikis from wikipedia.org'
    task wiki: :environment do
      player_wikis_count = 0
      teams_looped_through = 0
      league = ActivePlayer::Attr.get
      league.each do |abbr, players|
        players.each do |player|          
          FileUtils::mkdir_p("vendor/player_wiki/#{abbr.downcase}")
          link_src = open("https://en.wikipedia.org/wiki/#{player[:link]}")
          link_dest = "vendor/player_wiki/#{abbr.downcase}/#{player[:link]}.html"          
          IO.copy_stream(link_src, link_dest)
          if File.file? link_dest
            player_wikis_count += 1
            puts "#{player_wikis_count}: #{player[:last_name]}'s wiki has been stored at".green
            puts "==>#{link_dest}"
          else
            puts "Failed to store #{player[:last_name]}'s wiki page".red.bold
            break
          end          
        end
        teams_looped_through += 1
        puts "#{teams_looped_through} teams looped through".light_blue
      end
      "#{player_wikis_count} player wikis downloaded".bold
    end
  
  end
end
