class GamePlayer < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_one :game_country

  scope :pending_invite, -> { where( 'pending' ) }
  scope :confirmed, -> { where( 'confirmed' ) }
  scope :invited_or_confirmed, -> { pending_invite.or( confirmed ) }
  scope :pending_start, -> { where.not( 'pending' ).where( 'confirmed' ).joins( :game ).merge( Game.pending ) }

  def invite_status
    if pending
      'invited'
    elsif confirmed
      'accepted'
    else
      'declined'
    end
  end
end
