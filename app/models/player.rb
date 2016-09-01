class Player < ApplicationRecord
  belongs_to :team

  has_many :gameweeks
  has_many :squad_players
  has_many :squads, through: :squad_players


  def calculate_total_points
    puts "Updating total points for #{self.name}"
    @total_weekly_scores = gameweeks.map(&:calculate_gameweek_score)
    self.total_points = @total_weekly_scores.inject(:+)
    self.save!
  end

    def calculate_final_score
      total = points_minutes(minutes_played) + points_position + points_clean_sheet + points_match_score + points_yellow_card + points_red_card - points_conceded
      if player.total_points.nil?
        player.total_points = total
      else
        player.total_points += total
      end
    player.save!
    end

  def points_minutes(minutes_played)

    if minutes_played == 0
      -2
    elsif minutes_played > 60
      2
    else
      1
    end
  end

  def points_position
    if player.position == "Aanvaller"
      points = (gameweek.goal)*4
    elsif player.position == "Midfielder"
      points = (gameweek.goal)*5
    else
      points = (gameweek.goal)*6
    end
    return points
  end

  def points_clean_sheet
    if player.team.ga == 0 && player.position == "#{"Verdediger"}"
      4
    elsif player.team.ga == 0 && player.position == "#{"Keeper"}"
      4
    elsif player.team.ga == 0 && player.position == "#{"Midfielder"}"
      1
    else
      0
    end
  end


  def points_match_score
    if player.team.won == 0 && player.team.draw == 1
      1
    elsif player.team.won == 0 && player.team.draw == 0
      -1
    else
      2
    end
  end


  def points_yellow_card
    if gameweek.yellow_card == 1
      -1
    elsif gameweek.yellow_card == 2
      -3
    else
      0
    end
  end


  def points_red_card
    if gameweek.red_card == 1
      -3
    else
      0
    end
  end

  def points_conceded

    if player.team.ga.even? && player.position == "#{"Verdediger"}"
      points = player.team.ga / 2
    elsif player.team.ga.even? && player.position == "#{"Keeper"}"
      points = player.team.ga / 2
    else
      points = 0
    end
    return points
  end
end
