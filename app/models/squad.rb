class Squad < ApplicationRecord
  belongs_to :user

  has_many :squad_players
  has_many :players, through: :squad_players
  has_many :gameweeks, through: :players
  has_many :gameweek_squad_players
end
