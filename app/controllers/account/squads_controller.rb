class Account::SquadsController < ApplicationController
  before_action :set_squad

  def show
  end

  def new
    @squad = Squad.new

    # @goalkeepers  = Player.where(position: "Keeper")
    # @defenders    = Player.where(position: "Verdediger")
    # @midfields    = Player.where(position: "Middenvelder")
    # @forwards     = Player.where(position: "Aanvaller")

    # @new_goalkeepers = 2.times.map { SquadPlayer.new }  
    # @new_defenders   = 5.times.map { SquadPlayer.new }  
    # @new_midfields   = 5.times.map { SquadPlayer.new }  
    # @new_forwards    = 3.times.map { SquadPlayer.new }  
  end

  def create
    @squad = Squad.new(squad_params)
    @squad.budget = 100
    @squad.user = current_user

    if @squad.save
      redirect_to selection_account_squad_path
    else
      render :new
    end
  end

  def selection
    @teams = Team.all.order(:name)

    @team = @teams.first
    @team_players = @team.players.where.not(id: @squad.player_ids)

    @squad_players = @squad.squad_players.joins(:player)

    # selected players
    @squad_goalkeepers  = @squad_players.where(players: { position: "Keeper" }).order("players.name")
    @squad_defenders    = @squad_players.where(players: { position: "Verdediger" }).order("players.name")
    @squad_midfields    = @squad_players.where(players: { position: "Middenvelder" }).order("players.name")
    @squad_forwards     = @squad_players.where(players: { position: "Aanvaller" }).order("players.name")

    # available players
    @team_goalkeepers  = @team_players.where(position: "Keeper").order(:name)
    @team_defenders    = @team_players.where(position: "Verdediger").order(:name)
    @team_midfields    = @team_players.where(position: "Middenvelder").order(:name)
    @team_forwards     = @team_players.where(position: "Aanvaller").order(:name)
  end

  def edit
  end

  def update
    @squad.update(squad_params)
    redirect_to account_squad_path(@squad)
  end

  private

  def squad_params
    params.require(:squad).permit(:name)

    # params[:squad][:squad_players_attributes] = params[:squad_players_attributes]

    # params.require(:squad).permit(
    #   :name, 
    #   :budget, 
    #   :total_points,
    #   squad_players_attributes: [:player_id]
    # )
  end

  def set_squad
    @squad = current_user.squad
  end
end





