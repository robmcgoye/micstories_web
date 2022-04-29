class ChaptersController < ApplicationController
  before_action :require_admin_user
  before_action :set_story, only: [ :new, :create ]
  before_action :set_chapter, only: [ :edit, :update, :destroy ]
   
  def edit
  end

  def new
    @chapter = @story.chapters.new
  end

  def create
    @chapter = @story.chapters.build( chapter_params )
    if @chapter.save
      flash[:notice] = "The chapter was successfully created"
      redirect_to back_to_story_path(@story.id)
    else
      render :new
    end
  end

  def update
    if @chapter.update( chapter_params )
      flash[:notice] = "The chapter was successfully updated"
      redirect_to back_to_story_path(@story.id)
    else
      render :edit
    end
  end

  def destroy
    @chapter.destroy
    flash[:notice] = "The chapter was successfully deleted"
    redirect_to back_to_story_path(@story.id)
  end

  private
    def set_story
      @story = Story.find(params[:story_id])
    end

    def set_chapter
      @chapter = Chapter.find(params[:id])
      @story = Story.find(@chapter.story_id)
    end

    def chapter_params
      params.require(:chapter).permit(:title, :subtitle, :sort_order)
    end

end