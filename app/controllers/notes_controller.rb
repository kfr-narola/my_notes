class NotesController < ApplicationController
  #load_and_authorize_resource param_method: :note_params

  before_action :set_note, only: [ :edit, :update, :destroy, :show ]
  before_action :set_sidebar, only: [ :index, :show, :edit]


  # GET /notes
  # GET /notes.json
  def index
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    # @comments = @note.comments.reverse_order.limit(10).paginate(page: params[:page], per_page: 10)
    @note = Note.find_by(id:params[:id])
    if !can? :read, @note
      redirect_to root_path, notice:"You are not authorized to access this page."
    end
  end

  # GET /notes/new
  def new
    @note = current_user.notes.new
    if current_user.autosave
      @note.title = "New Note"
      @note.description = "Write here.."
      @note.save
      respond_to do |format|
        format.js { redirect_to edit_note_path(@note) }
      end
    end
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    respond_to do |format|
      if @note.save
        @notes_list = current_user.notes
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        set_sidebar
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    #@note.destroy
    @note.update(status: 1)
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.js { redirect_to root_path, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    #
    ## TODO: Need to improve
    #
    # if params[:tags] == "1"
    #   @notes_list = Note.tagged_with(params[:search])
    # else
    #   @notes_list = Note.where("title like '%" + params[:search] + "%'")
    # end
    @notes_list = Note.where("title like '%#{params[:search]}%'").or(Note.where(id: Note.unscoped.tagged_with(params[:search])))
  end

  def mark_as_important
    note = current_user.notes.find_by(id: params[:id])
    note.important = params[:important]
    note.save
    set_sidebar
  end

  def autosave
    current_user.update(autosave:params[:autosave])
    set_sidebar
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def form_share_note
    @note = current_user.notes.find_by(id: params[:id])
  end

  def sharenote
    note = current_user.notes.find_by(id: params[:id])
    email = params[:email]
    user_edit = params[:user_edit]
    subject = "A #{ note.title } note shared by #{ current_user.profile.username }"
    url = "http://localhost:3000/notes/#{note.id}"
    if User.exists?(email: email)
      authority = note.permissions.new
      authority.user = User.find_by(email: email)
      authority.access = user_edit ? 1 : 0
      authority.save
      description = "You can access the notes here, just follow this link:";
      ShareNoteMailer.with(email: email, subject: subject, url: url, description: description ).share_notes_email.deliver_later
    else
      User.invite!({ email: email }, current_user)
    end
    redirect_to root_path, notice: 'Note was shared successfully.'
  end

  def request_note_edit
    note = Note.find_by(id:params[:id])
    puts params[:id]
    url = "http://localhost:3000#{assign_note_edit_path(note, current_user)}"
    subject = "#{ current_user.profile.username } wants edit permission for note #{ note.title }"
    description = "You can grant the edit notes permission here, just follow this link: or igonore for deny permissin.";
    ShareNoteMailer.with(email: current_user.email, subject: subject, url: url, description: description).share_notes_email.deliver_later
    redirect_to root_path, notice: 'Your edit note request sent successfully.'
  end

  def assign_note_edit
    note = current_user.notes.find_by(id:params[:id])
    user = User.find_by(id:params[:user])
    user.permissions.find_by(note_id: note.id).update(access:1)
    redirect_to root_path, notice: "#{user.profile.username} have assign edit Permission of notes #{note.title} successfully."
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sidebar
    @notes_list = current_user.notes
    @permission_notes_list = current_user.permissions
    puts current_user.id
  end

  def set_note
    @note = Note.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:title, :description, :tag_list, :important)
  end
end
