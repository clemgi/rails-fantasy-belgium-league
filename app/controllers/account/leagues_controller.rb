class Account::LeaguesController < ApplicationController

  def index
    @leagues = current_user.leagues
  end

  def show
    @league = League.find(params[:id])
  end

end
