class AddCaptainToSquadPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :squad_players, :captain, :boolean, null: false, default: false
  end
end
