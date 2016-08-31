class Account::SquadsController < ApplicationController
  before_action :set_squad
  before_action :check_existing_squad, only: [:new, :create]

  def show
    @squad_players = @squad.squad_players.joins(:player)

    @squad_goalkeepers  = @squad_players.where(players: { position: "Keeper" }, status: 'active').order("players.name")
    @squad_defenders    = @squad_players.where(players: { position: "Verdediger" }, status: 'active').order("players.name")
    @squad_midfields    = @squad_players.where(players: { position: "Middenvelder" }, status: 'active').order("players.name")
    @squad_forwards     = @squad_players.where(players: { position: "Aanvaller" }, status: 'active').order("players.name")

    @bench_goalkeepers  = @squad_players.where(players: { position: "Keeper" }, status: 'bench').order("players.name")
    @bench_defenders    = @squad_players.where(players: { position: "Verdediger" }, status: 'bench').order("players.name")
    @bench_midfields    = @squad_players.where(players: { position: "Middenvelder" }, status: 'bench').order("players.name")
    @bench_forwards     = @squad_players.where(players: { position: "Aanvaller" }, status: 'bench').order("players.name")


    @active_players     = @squad_players.where(status: 'active').order("players.name")
    @bench_players      = @squad_players.where(status: 'bench').order("players.name")
  end

  def new
    @squad = Squad.new
  end

  def create
    @squad = Squad.new(squad_params)
    @squad.budget = 100
    @squad.user = current_user
    @squad.total_points = 0

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

  def lineup
    if deadline?
      redirect_to '/account/squad'
      flash[:alert] = "Les changements ne sont pas autorisés pendant les jours de match"
    else

      @player_off = @squad.squad_players.where(player_id: params[:active_player]).first
      @player_on = @squad.squad_players.where(player_id: params[:bench_player]).first

      @player_off.status = 'bench'
      @player_on.status = 'active'
      @player_off.save!
      @player_on.save!

      team_valid? # error happens in here

      if @team_errors.empty?

        flash[:success] = "Transfer Successful!"
      else
        @player_off.status = 'active'
        @player_on.status = 'bench'
        @player_off.save!
        @player_on.save!

        flash[:alert] = @team_errors.first
      end

      redirect_to '/account/squad'
    end
  end

  def edit
  end

  def update
    @squad.update(squad_params)
    redirect_to account_squad_path(@squad)
  end

  private

  def deadline?
  #  start_time = Time.utc(*[0, 33, 10, 30, 8, 2016, 2, 243, true, "UTC"]) #seconds, minutes, hours, day, month, year, weekday, yearday isdst, zonefriday 20.30 everyweek
  #  end_time = Time.utc(*[0, 50, 10, 30, 8, 2016, 2, 243, true, "UTC"]) # monday morning

  #  if Time.now.between?(start_time, end_time)
  #   flash[:alert] = "Les changements ne sont pas autorisés pendant les jours de match"
  #   false
  # else
  #   true
  #  end
  false
  end

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

  def team_valid?
    @squad_players = @squad.squad_players.joins(:player)
    @team_errors = []

    unless @squad_players.where(players: { position: 'Keeper'},
      status: 'active').count == 1
      @team_errors << 'Must have at least one keeper'
    end
    unless @squad_players.where(players: { position: 'Verdediger'},
      status: 'active').count >= 3
      @team_errors << 'Must have at least three defenders'
    end
    unless @squad_players.where(players: { position: 'Middenvelder'},
      status: 'active').count >= 3
      @team_errors << 'Must have at least three midfielders'
    end
    unless @squad_players.where(players: { position: 'Aanvaller'},
      status: 'active').count >= 1
      @team_errors << 'Must have at least one striker'
    end
    unless @squad_players.where(status: 'active').count == 11

      @team_errors << "Must have 11 active players"
    end
  end
end
