class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :find_gameweek_number

  def find_gameweek_number
    @gameweeks = Gameweek.all
    @gameweek_number = @gameweeks.last.gameweek_number
  end

  def default_url_options
    { host: ENV['HOST'] || 'localhost:3000' }
  end

  # def snapshot(gameweek_number)
  #   @squad_players = SquadPlayers.all
  #   @squad_players.each do |p|
  #     gameweek_squad_players.create!(
  #       player_id: p.player_id,
  #       squad_id: p.squad_id,
  #       status: p.status,
  #       captain: p.captain,
  #       gameweek: gameweek_number
  #       )
  #   end
  # end

end
