class AddDetailsToGameweeks < ActiveRecord::Migration[5.0]
  def change
    add_column :gameweeks, :won, :integer
    add_column :gameweeks, :draw, :integer
    add_column :gameweeks, :lost, :integer
    add_column :gameweeks, :gf, :integer
    add_column :gameweeks, :ga, :integer
    add_column :gameweeks, :gd, :integer
  end
end
