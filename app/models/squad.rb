class Squad < ApplicationRecord
  belongs_to :user
  has_many :players_squads
  has_many :players, through: :players_squads
  has_and_belongs_to_many :players

  accepts_nested_attributes_for :players_squads
end
