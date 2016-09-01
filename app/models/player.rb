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

  def set_price
    if self.total_points <= 0
      self.price = 45
    elsif
      self.total_points <= 3
      self.price = 50
    elsif
      self.total_points <= 5
      self.price = 55
    elsif
      self.total_points <= 8
      self.price = 60
    elsif
      self.total_points <= 11
      self.price = 65
    elsif
      self.total_points <= 15
      self.price = 70
    elsif
      self.total_points <= 18
      self.price = 75
    else
      self.price = 80
    end
    puts 'Setting price for #{self.name}'
    self.save!
  end





end
