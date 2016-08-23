class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :position
      t.integer :price
      t.references :team, foreign_key: true
      t.integer :total_points

      t.timestamps
    end
  end
end
