class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :game_players
  has_many :games, through: :game_players

  validates :username, format: { with: /\A(?:[A-Za-z0-9_-]+)\Z/ }, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :all_except, -> ( user ) { where.not( id: user ) }

  def pending_invites
    game_players.where( 'pending' )
  end

end
