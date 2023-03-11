# frozen_string_literal: true

# Controller for Comments
class CommentsController < ApplicationController
  before_action :authenticate_user!

  # GET /comments or /comments.json
  def index
    redirect_to projects_path, notice: 'Unauthorised page'
  end

  # GET /comments/1 or /comments/1.json
  def show
    redirect_to projects_path, notice: 'Unauthorised page'
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    redirect_to projects_path, notice: 'Unauthorised page'
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    project = Project.find(comment_params[:project_id])

    respond_to do |format|
      if @comment.save
        Event.new(project: project, eventable: @comment).save
        format.html { redirect_to project_url(project), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: project }
      else
        format.html { render :show, status: :unprocessable_entity, location: project }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    redirect_to projects_path, notice: 'Unauthorised page'
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    redirect_to projects_path, notice: 'Unauthorised page'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:user_id, :text, :project_id)
  end
end
