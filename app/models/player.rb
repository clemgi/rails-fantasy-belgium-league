class Player < ApplicationRecord
  belongs_to :team

  has_many :gameweeks
  has_many :squad_players
  has_many :squads, through: :squad_players
end
