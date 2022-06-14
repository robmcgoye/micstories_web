module ApplicationHelper

  def get_settings_path
    if Setting.take.present?
      edit_setting_path( Setting.take )
    else
      new_setting_path
    end
  end 

  def get_meta_description
    if Setting.take.present?
      Setting.take.default_description
    end    
  end

end
