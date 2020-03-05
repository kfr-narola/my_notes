class Admins::DashboardController < AdminController
  def index
    @no_of_notes = Note.count
    @no_of_user = User.count
    @no_of_shared_notes = Permission.count
  end
end
