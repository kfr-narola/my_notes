class Admins::NotesController < AdminController
  before_action :set_ability
  def index
    @notes = Note.all
  end

  private

  def note_params
    params.require(:note).permit(:title, :description, :tag_list, :important)
  end

  def set_ability
    @current_ability ||= Ability.new(current_admin)  
  end
end
