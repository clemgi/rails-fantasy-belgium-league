class Profile::GameweeksController < ApplicationController

  def show
    @gameweek = Gameweek.find(params[:id])
  end

end
