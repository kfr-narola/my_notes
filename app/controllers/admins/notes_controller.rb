class Admins::NotesController < AdminController
  def index
    @current_ability ||= Ability.new(current_admin)
    @notes = Note.all
  end

  def edit
    @note = Note.find_by(id:params[:id])
  end

  def update
    @note = Note.find_by(id:params[:id])
    respond_to do |format|
      if @note.update(note_params)
        format.js { redirect_to admins_notes_path, notice: 'Note was successfully updated.' }
      end
    end
  end

  def destroy
    @note = Note.find_by(id:params[:id])
    @note.update(status: 1)
    respond_to do |format|
      format.js { redirect_to admins_notes_path, notice: 'Note was successfully deleted.' }
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :description, :tag_list, :important)
  end

end
