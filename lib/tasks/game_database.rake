require 'open-uri'
require 'json'

namespace :playnvote do
  desc "takes API from GiantBomb for various platforms and creates a massive database for the games."
  
  task :create_games_database => :environment do
    API_KEY = "da6db7f5db86d4fb7e7c8688d5d5c96184907fe7"
    PLATFORMS = ["94", "20", "35", "146", "145", "88", "129", "18", "116", "143", "86", "36", "139", "117", "52", "17", "152"]
    # PC, 360, PS3, PS4, Xbone, PSN(PS3), Vita, PSP, PSN(PSP), PSN(Vita), Xbox Marketplace, Wii, Wii U, 3DS, DS, Mac, Linux
    
    platform_abbrev = {"PlayStation 3"=>"PS3", "Xbox 360"=>"360", "PlayStation 4"=>"PS4", "Xbox One"=>"Xbone", "PC"=>"PC", 
                      "PlayStation Network (PS3)"=>"PSN (PS3)", "PlayStation Vita"=>"PSVita", "PlayStation Portable"=>"PSP", "PlayStation Network (PSP)"=>"PSN (PSP)",
                      "PlayStation Network (Vita)"=>"PSN (Vita)", "Xbox Live Marketplace"=>"Xbox Live", "Wii"=>"Wii", "Wii U"=> "Wii U", "Nintendo 3DS"=>"3DS", 
                      "Nintendo DS"=>"DS", "PlayStation 2"=>"PS2", "Mac"=>"Mac", "Xbox"=>"Xbox", "GameCube"=>"GameCube", "Game Boy Advance"=>"GBA", "Linux"=>"Linux" }

    games = Hash.new('games')
    games['games'] = []

    PLATFORMS.each do |plat|
      result = JSON.parse(open("http://www.giantbomb.com/api/games/?api_key=#{API_KEY}&format=json&filter=platforms:#{plat}").read)

      max_results = result['number_of_total_results']
      puts max_results
      offset = 0

      while offset <= max_results do
        result['results'].each_index do |i|
          unless games['games'].find{|g| g["id"] == result['results'][i]['id']}
            developer = JSON.parse(open("http://www.giantbomb.com/api/game/#{result['results'][i]['id']}/?api_key=#{API_KEY}&format=json&field_list=developers").read)
            games['games'] << { 'id' => result['results'][i]['id'],
                                'title' => result['results'][i]['name'], 
                                'release_date' => result['results'][i]['original_release_date'] ? DateTime.strptime(result['results'][i]['original_release_date'], '%Y-%m-%d %H:%M:%S').to_date : "No date", 
                                'cover_art' => result['results'][i]['image'] ? result['results'][i]['image']['super_url'] : "No image",
                                'developer' => developer['results']['developers'] ? Array.new(developer['results']['developers'].length){ |dev| developer['results']['developers'][dev]['name'] }.compact : ["No Data for Developer"],
                                'platforms' => Array.new(result['results'][i]['platforms'].length){ |p| platform_abbrev[result['results'][i]['platforms'][p]['name']] }.compact }
          end
        end

        offset += 100
        result = JSON.parse(open("http://www.giantbomb.com/api/games/?api_key=#{API_KEY}&format=json&offset=#{offset}&filter=platforms:#{plat}").read)
      end
      
      puts "Platform just checked: #{plat}"
      puts "Current size of all the games: #{games['games'].size}"
    end
    
    games['games'].each do |game|
      unless Game.find_by_giant_bomb_id(game['id'])
        unless game['platforms'].blank?
          Game.create(title: game['title'], release_date: game['release_date'], cover_art: game['cover_art'], platform: game['platforms'], giant_bomb_id: game['id'], developer: game['developer'])
        end
      end
    end
  end
end