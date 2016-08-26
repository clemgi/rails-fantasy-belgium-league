class Account::SquadPlayersController < ApplicationController
  def create
    @squad = current_user.squad
    @squad_player = @squad.squad_players.where(player_id: params[:player_id]).first_or_initialize

    if valid_squad_player?
      @squad_player.save
    else
      flash[:alert] = "NON"
    end

    redirect_to selection_account_squad_path
  end

  def edit
  end

  def update
    @squad = current_user.squad
    if squad_player.status ==
  end


  def destroy
    @squad = current_user.squad
    squad_player = @squad.squad_players.find(params[:id])
    squad_player.destroy

    redirect_to selection_account_squad_path
  end

  private

  def valid_squad_player?
    position = @squad_player.player.position
    selected_players_count = @squad.players.where(position: position).count

    expected_count = case position
    when "Keeper"
      2
    when "Verdediger", "Middenvelder"
      5
    when "Aanvaller"
      3
    end

    selected_players_count < expected_count
  end
end
