class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.paginate(page:1, per_page:4)
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @note = @comment.note
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Note.find_by(id:params[:note_id]).comments.new(comment_params)
    @note = @comment.note
    respond_to do |format|
      if @comment.save
        #format.html { redirect_to note_path(@comment.note), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
        format.js { render :layout => false }
      else
        #format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to note_path(@comment.note), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment_id = @comment.id
    @comment.destroy
    @comments_count = @comment.note.comments.count
    respond_to do |format|
      #format.html { redirect_to note_path(@comment.note), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  def pagination
    note = params[:note]
    page = params[:page].to_i
    @comments = Comment.where("note_id = #{note}").limit(10).offset(10 * (page-1).to_i)
    puts @comments.count
    @comments.each do | comment |
      puts comment.description
    end
    respond_to do |format|
      #format.html { redirect_to note_path(@comment.note), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:description,:note_id)
    end
end
