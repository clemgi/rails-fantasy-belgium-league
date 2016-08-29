module PagesHelper
  def get_team_logo(squad_player)
    "#{squad_player.player.team.name}.png"
  end

end
