class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :played
      t.integer :won
      t.integer :draw
      t.integer :lost
      t.integer :gf
      t.integer :ga
      t.integer :gd
      t.integer :points

      t.timestamps
    end
  end
end
