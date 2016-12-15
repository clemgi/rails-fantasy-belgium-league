class CreateGameweekSquadPlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :gameweek_squad_players do |t|
      t.integer :player_id
      t.integer :squad_id
      t.string :status
      t.boolean :captain
      t.integer :gameweek

      t.timestamps
    end
  end
end
