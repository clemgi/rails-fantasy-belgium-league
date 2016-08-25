class Gameweek < ApplicationRecord
  belongs_to :player

  after_create :calculate_final_score

  def calculate_final_score
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
    if team.ga == 0 && player.position == "#{"Verdediger"}"
      4
    elsif team.ga == 0 && player.position == "#{"Keeper"}"
      4
    elsif team.ga == 0 && player.position == "#{"Midfielder"}"
      1
    else
      0
    end
  end


  def points_match_score
    if team.won == 0 && team.draw == 1
      1
    elsif team.won == 0 && team.draw == 0
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

    if team.ga.even? && player.position == "#{"Verdediger"}"
      points = team.ga / 2
    elsif team.ga.even? && player.position == "#{"Keeper"}"
      points = team.ga / 2
    else
      points = 0
    end
    return points
  end

  # TODO add to the total point
  # def points_assist
  #   if player.position == "#{"Aanvaller"}"
  #     points = (self.assist)*4
  #   elsif player.position == "#{"Midfielder"}"
  #     points = (self.assist)*3
  #   else
  #     points = (self.assist)*4
  #   end
  #   return points
  # end

end




  # def calculate
  #   self.minutes_played = amount_minutes_played
  #   if self.day_points.nil?
  #     self.day_points = points_minutes_played(amount_of_minutes)
  #   else
  #     self.day_points += points_minutes_played(amount_of_minutes)
  #  end

  #   self.save!
  # end
  # def amount_minutes_played
  #   if self.gameweek_number == 1
  #     amount_of_minutes = self.minutes_played
  #   else
  #     previous_gameweek_number = self.gameweek_number - 1
  #     previous_gameweek = Gameweek.find(previous_gameweek_number)
  #     amount_of_minutes = self.minutes_played - previous_gameweek.minutes_played
  #   end
  # end
