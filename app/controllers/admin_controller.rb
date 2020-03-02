class AdminController < ApplicationController
  layout "admin"
  before_action :authenticated_admin

  def index
    @no_of_user = User.count
    @no_of_notes = Note.count
    @no_of_shared_notes = Permission.count
  end

  def manage_users
    @users = User.all
  end

  def manage_notes
    p Note.count
    @notes = Note.all
  end


  private

  def check_admin
    if current_admin.role != "admin"
      redirect_to root_path, notice:"You are not authorized to access this page."
    end
  end

end
