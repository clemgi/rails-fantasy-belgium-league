namespace :snapshot do
  desc "Save squad players"
  task run: [:environment] do
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
  end
end
