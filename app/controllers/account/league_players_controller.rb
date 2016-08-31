class Account::LeaguePlayersController < ApplicationController

  def create
    if League.where(name: params[:league_name]).empty?
      @leagues = current_user.leagues
      flash[:alert] = "Cette ligue n'existe pas"
      # render 'account/leagues/index'
      redirect_to account_leagues_path

    else
      @league = League.where(name: params[:league_name]).first
      unless @league.users.include?(current_user)
        @league.users << current_user
        @league.save!
      end
      redirect_to account_league_path(@league)
    end
  end
end
