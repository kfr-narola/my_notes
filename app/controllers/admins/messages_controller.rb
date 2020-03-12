class Admins::MessagesController < AdminController
  def index
    @users = User.all
  end
end
