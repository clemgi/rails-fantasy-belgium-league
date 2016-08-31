class Account::LeaguesController < ApplicationController

  def index
    @leagues = current_user.leagues
  end

  def show
    @league = League.find(params[:id])
    @managers = @league.users.sort{|a,b| a.squad.total_points <=> b.squad.total_points}.reverse

  end

end
