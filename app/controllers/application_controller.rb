class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :find_gameweek_number

  def default_url_options
    { host: ENV['HOST'] || 'localhost:3000' }
  end

  def find_gameweek_number
    @gameweeks = Gameweek.all
    @gameweek_number = @gameweeks.last.gameweek_number
  end
end
