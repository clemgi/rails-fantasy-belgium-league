require 'open-uri'
Gameweek_number = ENV['GAMEWEEK_NUMBER']
namespace :scraper do
  desc "Retrieves teams and players and put them in DB"
  task gameweek: [:environment] do
    ###################### FIND LATEST TEAM INFO ############################
    url_string = "http://sporza.be/cm/sporza/matchcenter/mc_voetbal/JupilerProLeague1617"
    index_page = Nokogiri::HTML(open(url_string))
    team_css = index_page.css('tbody > tr').each do |team_row|
      team_name = team_row.css('.team').children.first.children.text
      team_url = team_row.css('.team').children.first.attributes["href"].value
      games_played = team_row.css('td:nth-child(3)').children.first.text
      wins = team_row.css('td:nth-child(4)').children.first.text
      losses = team_row.css('td:nth-child(5)').children.first.text
      draws = team_row.css('td:nth-child(6)').children.first.text
      gf = team_row.css('td:nth-child(7)').children.first.text
      ga = team_row.css('td:nth-child(8)').children.first.text
      gd = team_row.css('td:nth-child(9)').children.first.text
      points = team_row.css('td:nth-child(10)').children.first.text
    ###################### FIND TEAM FROM DB ############################
      old_team = Team.find_by_name(team_name)
      puts old_team.name
    ###################### FIND TEAM PLAYER INFO ########################
      team_show_view = Nokogiri::HTML(open("http://sporza.be#{team_url}"))
      players_list = team_show_view.css('tbody > tr').each do |player_row|
        player_info = {}
        player_num = player_row.css('td:nth-child(1)').children.first.text
        player_info[:name] = player_row.css('td:nth-child(3)').children[1].children.text.strip
        player_info[:position] = player_row.css('td:nth-child(6)').children.first.attributes['title'].value
        player_info[:total_points] = 0
        player_info[:price] = 0
        player_info[:start] = player_row.css('td:nth-child(10)').children.first.text
        player_info[:minutes] = player_row.css('td:nth-child(8)').children.first.text
        player_info[:goals] = player_row.css('td:nth-child(12)').children.first.text
        player_info[:own_goals] = player_row.css('td:nth-child(13)').children.text
        player_info[:yellow] = player_row.css('td:nth-child(14)').children.first.text
        player_info[:red] = player_row.css('td:nth-child(15)').children.first.text
        old_player = old_team.players.find_by_name(player_info[:name])
      ###################### CREATE PLAYER IF NEEDED ########################
        unless old_player
          old_player = Player.create!(name: player_info[:name],
                                      position: player_info[:position],
                                      team_id: old_team.id,
                                      price: 0,
                                      total_points: 0)
        end
        puts old_player.name
      ###################### UPDATE PLAYER LATEST GAMEWEEK ########################
        if old_player.gameweeks.empty?
          # Add gameweek from scratch
          new_gameweek = old_player.gameweeks.build(gameweek_number: Gameweek_number,
                                                  player_id: old_player.id)
          new_gameweek.lineups = player_info[:start]
          new_gameweek.minutes_played = player_info[:minutes]
          new_gameweek.goal = player_info[:goals]
          new_gameweek.against_goal = player_info[:own_goals]
          new_gameweek.yellow_card = player_info[:yellow]
          new_gameweek.red_card = player_info[:red]
          new_gameweek.won = wins
          new_gameweek.lost = losses
          new_gameweek.draw = draws
          new_gameweek.ga = ga
          new_gameweek.gf = gf
          new_gameweek.gd = gd
          new_gameweek.save!
        else
          # Subtract totals from previous gameweek to get this week's numbers
          # We have access to player: old_player
          # We have access to his latest gameweek:
          # old_player.gameweeks.where(gameweek_number: GAMEWEEK_NUMBER-1)
          old_player.gameweeks.where(gameweek_number: Gameweek_number).destroy_all
          old_gameweek = old_player.gameweeks.where(gameweek_number: Gameweek_number-1).first
          new_gameweek = old_player.gameweeks.build(gameweek_number: Gameweek_number,
                                                  player_id: old_player.id)
          latest_lineups = player_info[:start].to_i - old_gameweek.lineups
          latest_minutes = player_info[:minutes].to_i - old_gameweek.minutes_played
          latest_goals = player_info[:goals].to_i - old_gameweek.goal
          latest_yellows = player_info[:yellow].to_i - old_gameweek.yellow_card
          latest_reds = player_info[:red].to_i - old_gameweek.red_card
          new_gameweek.lineups = latest_lineups
          new_gameweek.minutes_played = latest_minutes
          new_gameweek.goal = latest_goals
          new_gameweek.yellow_card = latest_yellows
          new_gameweek.red_card = latest_reds
          new_gameweek.won = wins.to_i - old_team.won
          new_gameweek.lost = losses.to_i - old_team.lost
          new_gameweek.draw = draws.to_i - old_team.draw
          new_gameweek.ga = ga.to_i - old_team.ga
          new_gameweek.gf = gf.to_i - old_team.gf
          new_gameweek.gd = gd.to_i - old_team.gd
          new_gameweek.save!
        end
      end
    ###################### UPDATE TEAM INFO ############################
      # Updates each team in DB to newest stats
      old_team.update!(played: games_played, won: wins, lost: losses,
                       draw: draws, gf: gf, ga: ga, gd: gd, points: points)
    end
  end
end
