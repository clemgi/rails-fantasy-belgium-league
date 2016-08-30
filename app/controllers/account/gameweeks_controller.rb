class Account::GameweeksController < ApplicationController
  before_action :find_gameweek_number

  def show
    @gameweeks = current_user.squad.gameweeks.where(gameweek_number: params[:id])
    @squad = current_user.squad
    @total_week_points = 0

    @gameweeks.each do |gameweek|
      @total_week_points += gameweek.day_points
    end

    # if @squad.total_points.nil? == false
    #   @squad.total_points += @total_week_points
    #   @squad.save
    # else
    #   @squad.total_points = @total_week_points
    #   @squad.save
    # end



    # @squad_players.players.each do |player|
    #   player.gameweeks.each do |gameweek|
    #    @squad.total_points  += gameweek.day_points
    #   end

  end

   private

    def find_gameweek_number
      @gameweeks = Gameweek.all
      @gameweek_number = @gameweeks.last.gameweek_number
    end
end
