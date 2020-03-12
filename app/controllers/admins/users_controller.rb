class Admins::UsersController < AdminController
  def index
    @current_ability ||= Ability.new(current_admin)
    @users = User.all
  end

  def edit
    @current_ability ||= Ability.new(current_admin)
    @user = User.find_by(id:params[:id])
  end

  def new
    @current_ability ||= Ability.new(current_admin)
    @user = User.new
  end

  def create
    @current_ability ||= Ability.new(current_admin)
    @user = User.create
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

  def new_mail
    @user = User.find_by(id:params[:user_id])
    puts @user.email
  end

  def send_mail
    attach = params[:attachment]
    url = Hash.new
    cnt = 0
    attach.each do | file |
      puts file.original_filename
      file_name = Time.now.to_i.to_s + file.original_filename
      path = File.join(Rails.root.join("public", "mail", "attach", file_name))
      File.open(path, "wb") { |f| f.write(file.read) }
      url.store(file_name, path)
    end
    AdminMailer.with(email: params[:email], subject: params[:subject], description: params[:description], attach: url).send_email.deliver_later
    respond_to do |format|
      format.html { redirect_to admins_users_path, notice: 'Your mail send successfully' }
    end
  end

  def destroy
    @user = User.find_by(id:params[:id])
    if @user.destroy
      respond_to do |format|
        format.js { redirect_to admins_users_path, notice: 'User was successfully deleted.' }
      end
    end
  end

  private

  def profile_paramas
    params.require(:profile).permit(:username, :gender, :phone, :birthdate, :avatar)
  end
end
