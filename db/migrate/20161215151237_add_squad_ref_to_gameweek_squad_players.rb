class AddSquadRefToGameweekSquadPlayers < ActiveRecord::Migration[5.0]
  def change
    add_reference :gameweek_squad_players, :squad, foreign_key: true
  end
end
