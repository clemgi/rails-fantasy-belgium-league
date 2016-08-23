class Profile::SquadController < ApplicationController
  before_action :set_squad

  def show
  end

  def edit
  end

  def update
    @squad.update(squad_params)
    redirect_to profile_squad_path(@squad)
  end

  private

  def squad_params
    params.require(:squad).permit(:name, :budget, :total_points)
  end

  def set_squad
    @squad = Squad.find(params[:id])
  end

end





