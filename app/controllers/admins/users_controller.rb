class Admins::UsersController < AdminController
  def index
    @current_ability ||= Ability.new(current_admin)
    @users = User.all
  end

  def edit
    @current_ability ||= Ability.new(current_admin)
    @user = User.find_by(id:params[:id])
  end

  def update
    @current_ability ||= Ability.new(current_admin)
    @profile = User.find_by(id:params[:id]).profile
    p @profile.username
    if @profile.update(profile_paramas)
      respond_to do |format|
        format.js { redirect_to admins_users_path, notice: 'User was successfully updated.' }
      end
    end
  end

  def destroy
    
  end

  private

  def profile_paramas
    params.require(:profile).permit(:username, :gender, :phone, :birthdate, :avatar)
  end
end
