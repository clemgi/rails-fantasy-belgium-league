namespace :snapshot do
  desc "Save squad players"
  task update: [:environment] do
    puts "Are you sure you want to delete all Squad_players for gameweek #{ENV['GAMEWEEK_NUMBER']}? (Y/N)"
    if STDIN.gets.chomp == "Y"
      GameweekSquadPlayer.where(gameweek: ENV['GAMEWEEK_NUMBER']).delete_all
      @squad_players = SquadPlayer.all
      @squad_players.each do |p|
        GameweekSquadPlayer.create!(
          player_id: p.player_id,
          squad_id: p.squad_id,
          status: p.status,
          captain: p.captain,
          gameweek: ENV['GAMEWEEK_NUMBER']
          )
      end
      puts "you updated all Squad Players for gameweek #{ENV['GAMEWEEK_NUMBER']}"
    else
      puts "Nothing done"
    end
  end
end

