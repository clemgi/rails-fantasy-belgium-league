class Account::SquadPlayersController < ApplicationController
  def create 
    @squad = current_user.squad
    @squad.squad_players.where(player_id: params[:player_id]).first_or_create

    redirect_to selection_account_squad_path
  end

  def destroy
    @squad = current_user.squad
    squad_player = @squad.squad_players.find(params[:id])
    squad_player.destroy

    redirect_to selection_account_squad_path
  end
end