class Player < ApplicationRecord
  belongs_to :team
  has_and_belongs_to_many :squads
  has_many :gameweeks
end
