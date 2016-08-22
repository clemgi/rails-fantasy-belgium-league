class CreateLeaguesAndUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :leagues_users, id:false do |t|
      t.integer :league_id
      t.integer :user_id
    end

    add_index :leagues_users, :league_id
    add_index :leagues_users, :user_id
  end
end





