namespace :gameweek_points do
  desc "Add points and put them in the squad total points"
  task update: [:environment] do

    Squad.all.each do |squad|
      squad.squad_players.where(status: 'active').each do |squad_player|
        gameweek = squad_player.player.gameweeks.where(gameweek_number: 5).first
        squad.total_points += gameweek.day_points
      end
      squad.save!
      puts "Added points for #{squad.name}"
    end
  end
end
