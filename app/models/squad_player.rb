class SquadPlayer < ApplicationRecord
  belongs_to :squad
  belongs_to :player
end