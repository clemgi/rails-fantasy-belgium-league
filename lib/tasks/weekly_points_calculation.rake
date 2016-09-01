namespace :gameweek_points do
  desc "Add points and put them in the squad total points"
  task update: [:environment] do

    Squad.all.each do |squad|
      squad.squad_players.where(status: 'active').each do |squad_player|
        gameweek = squad_player.player.gameweeks.where(gameweek_number: ENV['GAMEWEEK_NUMBER']).first
        if squad.total_points.nil?
          squad.total_points = gameweek.day_points
        else
        squad.total_points += gameweek.day_points
        end
      end
      squad.save!
      puts "Added points for #{squad.name}"
    end

    Player.all.each do |player|
      player.calculate_total_points
    end
  end
end


