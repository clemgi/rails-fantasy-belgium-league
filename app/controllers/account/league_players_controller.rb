class Account::LeaguePlayersController < ApplicationController

  def create
    if League.where(name: params[:league_name]).empty?
      flash[:error] = 'No such league'
      @leagues = current_user.leagues
      render 'account/leagues/index'
    else
      @league = League.where(name: params[:league_name]).first
      @league.users << current_user
      @league.save!
      redirect_to account_league_path(@league)
    end
  end
end