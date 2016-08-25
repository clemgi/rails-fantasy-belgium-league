class Squad < ApplicationRecord
  belongs_to :user
  
  has_many :squad_players
  has_many :players, through: :squad_players

  accepts_nested_attributes_for :squad_players
end
