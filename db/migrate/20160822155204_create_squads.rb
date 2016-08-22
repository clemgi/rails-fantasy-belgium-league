class CreateSquads < ActiveRecord::Migration[5.0]
  def change
    create_table :squads do |t|
      t.integer :budget
      t.integer :total_points
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
