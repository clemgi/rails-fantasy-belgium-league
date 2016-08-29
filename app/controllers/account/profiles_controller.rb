class Account::ProfilesController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    current_user.update(user_params)
    redirect_to account_profile_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:nickname)
  end

end
