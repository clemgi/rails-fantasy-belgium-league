class Squad < ApplicationRecord
  belongs_to :user
   has_many :players, through: :players_squads
   has_and_belongs_to_many :players
end
