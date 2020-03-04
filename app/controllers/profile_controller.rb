class ProfileController < ApplicationController
  before_action :check_valid_user, only: [ :index ]

  def show
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    @profile.update(profile_paramas)
    redirect_to profile_path, notice:"Profile Details successfully Updated."
  end



private
  # Use callbacks to share common setup or constraints between actions.
  def check_valid_user
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def profile_paramas
    params.require(:profile).permit(:username, :gender, :phone, :birthdate, :avatar)
  end

end
