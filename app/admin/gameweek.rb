ActiveAdmin.register Gameweek, as: 'Player Scores' do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

index do
  selectable_column
  column :gameweek_number
  column :id
  column :player
  column :team
  column :lineups do |i|
    div :class => "data" do
      best_in_place i, :lineups, type: :input, url: admin_player_scores_path
    end
  end
  column :minutes_played do |i|
    div :class => "data" do
      best_in_place i, :minutes_played, type: :input, url: admin_player_scores_path
    end
  end
  column :goal do |i|
    div :class => "data" do
      best_in_place i, :goal, type: :input, url: admin_player_scores_path
    end
  end
  column :against_goal do |i|
    div :class => "data" do
      best_in_place i, :against_goal, type: :input, url: admin_player_scores_path
    end
  end
  column :assist do |i|
    div :class => "data" do
      best_in_place i, :assist, type: :input, url: admin_player_scores_path
    end
  end
  column :yellow_card do |i|
    div :class => "data" do
      best_in_place i, :yellow_card, type: :input, url: admin_player_scores_path
    end
  end
  column :red_card do |i|
    div :class => "data" do
      best_in_place i, :red_card, type: :input, url: admin_player_scores_path
    end
  end
  column :won do |i|
    div :class => "data" do
      best_in_place i, :won, type: :input, url: admin_player_scores_path
    end
  end
  column :draw do |i|
    div :class => "data" do
      best_in_place i, :draw, type: :input, url: admin_player_scores_path
    end
  end
  column :lost do |i|
   div :class => "data" do
    best_in_place i, :lost, type: :input, url: admin_player_scores_path
  end
end
actions
end

batch_action :add_1_lineup do |ids|
  Gameweek.find(ids).each do |gameweek|
    gameweek.lineups = 1
  end
  redirect_to collection_path, alert: "Selected players have been added to lineups"
end

# filter :team_id,
#    collection: -> { Player.team.all },
#    label:      'Team'
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
end


