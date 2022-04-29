class PartsController < ApplicationController
  before_action :require_admin_user, except: [:show]
  before_action :set_chapter, only: [:new, :create]
  before_action :set_part, only: [:show, :edit, :update, :destroy]

  # def index
  #   @parts = @chapter.parts
  # end

  def show
  end

  def new
    @part = @chapter.parts.new
  end

  def edit
  end

  def create
    @part = @chapter.parts.build( part_params )
    if @part.save
      flash[:notice] = "Part was successfully created"
      redirect_to part_path(@part)
    else
      render :new
    end
  end

  def update
    if @part.update( part_params )
      flash[:notice] = "Part was successfully updated"
      redirect_to part_path(@part)
    else
      render :edit
    end
  end

  def destroy
    @part.destroy
    flash[:notice] = "Part was successfully deleted"
    redirect_to back_to_story_path(@story.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:chapter_id])
      @story = Story.find(@chapter.story_id)
    end

    def set_part
      @part = Part.find(params[:id])
      @chapter = Chapter.find(@part.chapter_id)
      @story = Story.find(@chapter.story_id)
      cookie_name = "story_#{@story.id}"
      cookies[cookie_name] = params[:id]
    end

    # Only allow a list of trusted parameters through.
    def part_params
      params.require(:part).permit(:title, :subtitle, :chat_title, :sort_order, :published, :content, :publish_at)
    end
end
