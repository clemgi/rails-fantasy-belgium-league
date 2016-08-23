class SquadsController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    @squad = Squad.new
  end

  def create
    @squad = Squad.new(squad_params)
    @squad.user = current_user

    if @place.save
      redirect_to profile_path
    else
      render :new
    end
  end


  private

  def squad_params
    params.require(:squad).permit(:name, :budget, :total_points)
  end

end

