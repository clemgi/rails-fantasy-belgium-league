namespace :snapshot do
  desc "Save squad players"
  task run: [:environment] do
    if GameweekSquadPlayer.where(gameweek: ENV['GAMEWEEK_NUMBER']).count > 0
      puts "You already took a snapshot for gameweek #{ENV['GAMEWEEK_NUMBER']}!"
    else
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
    puts "You took a Snapshot of all Squad_players for gameweek #{ENV['GAMEWEEK_NUMBER']}"
    end
  end
end
