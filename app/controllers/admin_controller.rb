class AdminController < ActionController::Base
  before_action :authenticate_admin!
  # #< ApplicationController
  layout "admin"

  private

  def after_sign_in_path_for(admin)
    stored_location_for(admin) || welcome_path
  end

end
