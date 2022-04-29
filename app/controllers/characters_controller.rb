class CharactersController < ApplicationController
  before_action :require_admin_user
  before_action :set_story, only: [ :index, :new, :create ]
  before_action :set_character, only: [ :edit, :update, :destroy ]

  def index
    @characters = @story.characters
  end

  # def show
  # end

  def new
    @character = @story.characters.new
  end

  def edit
  end

  def create
    @character = @story.characters.build( character_params )
    if @character.save
      flash[:notice] = "Character was successfully created"
      redirect_to back_to_story_path(@story.id)
    else
      render :new
    end
  end

  def update
    if @character.update( character_params )
      flash[:notice] = "Character was successfully updated"
      redirect_to back_to_story_path(@story.id)
    else
      render :edit
    end
  end

  def destroy
    @character.destroy
    flash[:notice] = "Character was successfully deleted"
    redirect_to back_to_story_path(@story.id)
  end

  private
    def set_story
      @story = Story.find(params[:story_id])
    end

    def set_character
      @character = Character.find(params[:id])
      @story = Story.find(@character.story_id)
    end

    def character_params
      params.require(:character).permit(:full_name, :chat_name, :sort_order, :description)
    end
end
