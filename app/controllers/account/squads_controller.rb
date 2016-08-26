class Account::SquadsController < ApplicationController
  before_action :set_squad
  before_action :find_gameweek_number
  before_action :check_existing_squad, only: [:new, :create]

  def show
    @squad_players = @squad.squad_players.joins(:player)

    @squad_goalkeepers  = @squad_players.where(players: { position: "Keeper" }).order("players.name")
    @squad_defenders    = @squad_players.where(players: { position: "Verdediger" }).order("players.name")
    @squad_midfields    = @squad_players.where(players: { position: "Middenvelder" }).order("players.name")
    @squad_forwards     = @squad_players.where(players: { position: "Aanvaller" }).order("players.name")
  end

  def new
    @squad = Squad.new
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

    if params[:team_id]
      find_team
    else
      @team = @teams.first
   end

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

  def check_existing_squad
    return unless current_user.squad

    if current_user.squad.players.count < 15
      redirect_to selection_account_squad_path
    else
      redirect_to account_squad_path
    end
  end

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

  def find_team
    @team = Team.find(params[:team_id])
  end

  def find_gameweek_number
    @gameweeks = Gameweek.all
    @gameweek_number = @gameweeks.last.gameweek_number
  end
end
