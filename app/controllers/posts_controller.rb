class PostsController < ApplicationController
  before_action :require_admin_user
  before_action :set_part, only: [ :new, :create ]
  before_action :set_post, only: [ :edit, :update, :destroy ]

  def new
    @post = @part.posts.new
  end

  def edit
  end

  def create
    @post = @part.posts.build( post_params )
    if @post.save
      flash[:notice] = "Post was successfully created"
      redirect_to back_to_story_path(@part.chapter.story_id)
    else
      render :new
    end
  end

  def update
    if @post.update( post_params )
      flash[:notice] = "Post was successfully updated"
      redirect_to back_to_story_path(@part.chapter.story_id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post was successfully deleted"
    redirect_to back_to_story_path(@part.chapter.story_id)
  end

  private
    def set_part
      @part = Part.find(params[:part_id])
    end

    def set_post
      @post = Post.find(params[:id])
      @part = Part.find(@post.part_id)
    end

    def post_params
      params.require(:post).permit(:published, :publish_at, :sort_order, :character_id, :message)
    end
end
