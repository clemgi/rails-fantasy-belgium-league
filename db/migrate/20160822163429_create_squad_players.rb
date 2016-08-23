class CreateSquadPlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players_squads do |t|
      t.references :player
      t.references :squad
      t.string :status
    end
  end
end
