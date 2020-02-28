class AdminController < ApplicationController
  layout 'admin_lte_2'

  before_action :check_admin
  def index

  end

  private
  def check_admin
    if current_user.role != "admin"
      redirect_to root_path, notice:"You are not authorized to access this page."
    end
  end
end
