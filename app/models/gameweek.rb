class Gameweek < ApplicationRecord
  belongs_to :player

  #TODO implement a methode for the minutes_played
  #Not played: -2
  #For playing up to 60 minutes : 1
  #For playing 60 minutes or more : 2

  def calculate
    self.minutes_played = amount_minutes_played
    self.day_points.nil? ? self.day_points = points_minutes_played(amount_of_minutes) : self.day_points += points_minutes_played(amount_of_minutes)
    self.save!
  end

  def amount_minutes_played
    if self.gameweek_number == 1
      amount_of_minutes = self.minutes_played
    else
      previous_gameweek_number = self.gameweek_number - 1
      previous_gameweek = Gameweek.find(previous_gameweek_number)
      amount_of_minutes = self.minutes_played - previous_gameweek.minutes_played
    end
  end

  def points_minutes_played(minutes_played)
    if minutes_played == 0
      -2
    elsif minutes_played > 60
      2
    else
      1
    end
  end
end



