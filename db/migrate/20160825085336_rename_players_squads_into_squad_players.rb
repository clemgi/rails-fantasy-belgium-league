class RenamePlayersSquadsIntoSquadPlayers < ActiveRecord::Migration[5.0]
  def change
    rename_table :players_squads, :squad_players
  end
end
