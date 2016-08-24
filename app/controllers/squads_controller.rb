class SquadsController < ApplicationController
  def new
    @squad = Squad.new

    @goalkeepers  = Player.where(position: "Keeper")
    @defenders    = Player.where(position: "Verdediger")
    @midfields    = Player.where(position: "Middenvelder")
    @forwards     = Player.where(position: "Aanvaller")


    @new_goalkeepers = 2.times.map { PlayersSquad.new }  
    @new_defenders   = 5.times.map { PlayersSquad.new }  
    @new_midfields   = 5.times.map { PlayersSquad.new }  
    @new_forwards    = 3.times.map { PlayersSquad.new }  
  end

  def create
    @squad = Squad.new(squad_params)
    @squad.user = current_user

    if @squad.save
      redirect_to profile_path
    else
      render :new
    end
  end


  private

  def squad_params
    params[:squad][:players_squads_attributes] = params[:players_squads_attributes]

    params.require(:squad).permit(
      :name, 
      :budget, 
      :total_points,
      players_squads_attributes: [:player_id]
    )
  end

end

