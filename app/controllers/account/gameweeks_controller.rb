class Account::GameweeksController < ApplicationController

  def show
    @gameweeks = current_user.squad.gameweeks.where(gameweek_number: params[:id])
  end

#   def create
#     gameweek = Gameweek.new(data_from_scraper)
#     gameweek.add_minutes_played(data_from_scraper[:minutes_played])
#     if gameweek.save
#       redirect_to whatever
#     else
#       render something else
#     end
#   end

#   private

# def data_from_scraper
#   {
#     minutes_played: buqgbqruigb
#   }
# end

end
