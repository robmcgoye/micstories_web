class SettingsController < ApplicationController
  before_action :require_admin_user
  before_action :set_setting, only: [ :edit, :update ]

  def new
    @setting = Setting.new
  end

  def create
    @setting = Setting.new( setting_params )
    if @setting.save
      flash[:notice] = "Settings were successfully updated"
      redirect_to edit_setting_path(@setting)
      # render :new
    end
  end

  def edit
  end

  def update
    if @setting.update( setting_params )
      flash[:notice] = "Settings were successfully updated"
      redirect_to edit_setting_path(@setting)
    else
      render :edit
    end
  end

  private
  
  def set_setting
    @setting = Setting.find(params[:id])
  end

  def setting_params
    params.require(:setting).permit(:spotlight_story_id, :default_description)
  end

end