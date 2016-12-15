class RemovePlayerAndSquadIdFromGameweekSquadPlayers < ActiveRecord::Migration[5.0]
  def change
    remove_column :gameweek_squad_players, :player_id, :integer
    remove_column :gameweek_squad_players, :squad_id, :integer
  end
end
