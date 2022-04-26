class ChaptersController < ApplicationController
  before_action :set_story, only: %i[ new edit update create destroy]

  def edit
    @chapter = @story.chapters.find(params[:id])
  end

  def new
    @chapter = @story.chapters.new
  end

  def create
    @chapter = @story.chapters.build( chapter_params )
    if @chapter.save
      flash[:notice] = "The chapter was successfully created"
      redirect_to story_url(@story)
    else
      render :new
    end
  end

  def update
    if @story.chapters.find(params[:id]).update( chapter_params )
      flash[:notice] = "The chapter was successfully updated"
      redirect_to story_url(@story)
    else
      render :edit
    end
  end

  def destroy
    @story.chapters.find(params[:id]).destroy
    flash[:notice] = "The chapter was successfully deleted"
    redirect_to story_url(@story)
  end

  private
    def set_story
      @story = Story.find(params[:story_id])
    end

    def chapter_params
      params.require(:chapter).permit(:title, :subtitle, :sort_order)
    end

end