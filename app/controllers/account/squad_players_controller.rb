class Account::SquadPlayersController < ApplicationController
  def create
    @squad = current_user.squad
    @squad_player = @squad.squad_players.where(player_id: params[:player_id]).first_or_initialize

    set_bench_status

    if valid_squad_player? && team_players_rules
      @squad_player.save
    else
      flash[:alert] = "NON"
    end

    redirect_to selection_account_squad_path
  end

  def edit
  end

  def update
  end


  def destroy
    @squad = current_user.squad
    squad_player = @squad.squad_players.find(params[:id])
    squad_player.destroy

    redirect_to selection_account_squad_path
  end

  def lineup
    @squad = current_user.squad
  end

  private

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
