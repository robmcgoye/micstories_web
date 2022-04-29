class StoriesController < ApplicationController
  before_action :set_story, only: %i[ edit update destroy ]
  before_action :require_admin_user

  def new
    @story = Story.new
  end

  def edit
  end

  def create
    @story = Story.new(story_params)
    if @story.save
      flash[:notice] = "Story was successfully created."
      redirect_to back_to_story_path(@story.id)
    else
      render :new
    end
  end

  def update
      if @story.update(story_params)
        flash[:notice] = "Story was successfully updated."
        redirect_to back_to_story_path(@story.id)
      else
        render :edit
      end
  end

  def destroy
    @story.destroy
    flash[:notice] = "Story was successfully destroyed."
    redirect_to about_path
  end

  private
    def set_story
      @story = Story.find(params[:id])
    end

    def story_params
      params.require(:story).permit(:long_title, :short_title, :header_picture, 
                                    :published, :author, :sort_order)
      # params.fetch(:story, {})
    end
end
