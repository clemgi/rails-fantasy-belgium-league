class Squad < ApplicationRecord
  belongs_to :user
  
  has_many :squad_players
  has_many :players, through: :squad_players

  validate :has_max_15_players

  private

  def has_max_15_players
    
  end
end
