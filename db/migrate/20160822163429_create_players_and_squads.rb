class CreatePlayersAndSquads < ActiveRecord::Migration[5.0]
  def change
    create_table :players_squads, id:false do |t|
      t.integer :player_id
      t.integer :squad_id
    end

    add_index :players_squads, :player_id
    add_index :players_squads, :squad_id
  end
end
