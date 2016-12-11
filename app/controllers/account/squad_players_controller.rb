class Account::SquadPlayersController < ApplicationController

  def create

    if deadline?
      redirect_to selection_account_squad_path
      flash[:alert] = "Les changements ne sont pas autorisés pendant les jours de match"
    else
    @squad = current_user.squad
    @squad_player = @squad.squad_players.where(player_id: params[:player_id]).first_or_initialize
    set_bench_status

    if set_budget && valid_squad_player? && team_players_rules
      @squad_player.save
    else
      flash[:alert] = "Vous ne pouvez pas prendre que les meilleurs joueurs... ;)"
    end

    redirect_to selection_account_squad_path
    end
  end

  def edit
  end

  def update
  end


  def destroy
    if deadline?
      redirect_to selection_account_squad_path
      flash[:alert] = "Les changements ne sont pas autorisés pendant les jours de match"
    else
    @squad = current_user.squad
    squad_player = @squad.squad_players.find(params[:id])
    squad_player.destroy

    redirect_to selection_account_squad_path
    end
  end

  private



  def deadline?
  #  start_time = Time.utc(*[0, 33, 10, 30, 8, 2016, 2, 243, true, "UTC+2"]) #seconds, minutes, hours, day, month, year, weekday, yearday isdst, zonefriday 20.30 everyweek
  #  end_time = Time.utc(*[0, 4, 11, 30, 8, 2016, 2, 243, true, "UTC+2"]) # monday morning

  #  if Time.now.between?(start_time, end_time)
  #   false
  # else
  #   true
  #  end
  false
  end

  def valid_squad_player?
    position = @squad_player.player.position
    selected_players_count = @squad.players.where(position: position).count

    expected_count = case position
    when "Keeper"
      2
    when "Verdediger", "Middenvelder"
      5
    when "Aanvaller"
      3
    end

    selected_players_count < expected_count
  end

  def team_players_rules
    team = @squad_player.player.team
    selected_players_count = @squad.players.where(team_id: team.id).count

    expected_count = 3

    selected_players_count < expected_count
  end


  def set_budget
    total_price = 0
    @squad.players.each do |player|
      total_price += player.price
    end
    budget = 800
    total_price < budget
  end

   def set_bench_status
    @position = @squad_player.player.position
    @squad_player.status = 'active'
    case @position
    when 'Keeper'
      @squad_player.status = 'bench' if @squad.squad_players.select{|squad_player| squad_player.player.position == @position }.count >= 2
    when 'Verdediger'
      @squad_player.status = 'bench' if @squad.squad_players.select{|squad_player| squad_player.player.position == @position }.count >= 5
    when 'Middenvelder'
      @squad_player.status = 'bench' if @squad.squad_players.select{|squad_player| squad_player.player.position == @position }.count >= 5
    when 'Aanvaller'
      @squad_player.status = 'bench' if @squad.squad_players.select{|squad_player| squad_player.player.position == @position }.count >= 3
   end
  end

end
