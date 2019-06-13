class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def accept_invite
    invite = current_user.pending_invites.find( params[:invite_id] )

    invite.update({ pending: false, confirmed: true })

    redirect_to game_path( invite.game )
  end

  def decline_invite
    invite = current_user.pending_invites.find( params[:invite_id] )

    invite.update({ pending: false, confirmed: false })

    redirect_to profile_path
  end
end
