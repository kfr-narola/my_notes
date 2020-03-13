class Admins::DashboardController < AdminController
  def index
    @no_of_notes = Note.count
    @no_of_user = User.count
    @no_of_shared_notes = Permission.count
    if !current_admin.avatar.attached?
      current_admin.avatar.attach(io: File.open("public/icon.jpeg"), filename: "icon.jpeg", content_type: "image/jpeg")
    end
  end
end
