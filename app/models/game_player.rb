class GamePlayer < ApplicationRecord
  belongs_to :game
  belongs_to :user

  scope :pending_invite, -> { where( 'pending' ) }
  scope :pending_start, -> { where.not( 'pending' ).where( 'confirmed' ).joins( :game ).merge( Game.pending ) }
end
