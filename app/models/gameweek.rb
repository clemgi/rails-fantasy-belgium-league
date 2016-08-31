class Gameweek < ApplicationRecord
  belongs_to :player
  after_create :calculate_final_score


  def set_active
    if player.squad_players.status == "#{"active"}"
      true
    else
      self.day_points = 0
    end
  end


  def calculate_final_score
    set_active
    points_total = points_minutes(minutes_played) + points_position + points_clean_sheet + points_match_score + points_yellow_card + points_red_card - points_conceded

    if self.day_points.nil?
      self.day_points = points_total
    else
      self.day_points += points_total
    end
    self.save!
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
    if player.position == "#{"Aanvaller"}"
      points = (self.goal)*4
    elsif player.position == "#{"Midfielder"}"
      points = (self.goal)*5
    else
      points = (self.goal)*6
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
    if self.yellow_card == 1
      -1
    elsif self.yellow_card == 2
      -3
    else
      0
    end
  end


  def points_red_card
    if self.red_card == 1
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




