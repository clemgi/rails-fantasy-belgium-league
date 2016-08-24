class CreateGameweeks < ActiveRecord::Migration[5.0]
  def change
    create_table :gameweeks do |t|
      t.integer :gameweek_number
      t.integer :lineups
      t.integer :minutes_played
      t.integer :goal
      t.integer :against_goal
      t.integer :assist
      t.integer :yellow_card
      t.integer :red_card
      t.integer :day_points
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
