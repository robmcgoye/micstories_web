module StoriesHelper
  
  def back_to_story_path(story_id)    
    cookie_name = "story_#{story_id}"
    if !cookies[cookie_name].nil?
      part = Part.where(id: cookies[cookie_name]).take
      if (part.present? && part.chapter.story_id == story_id) && (admin_user? || (part.published && part.publish_at <= Date.today))
        last_viewed_part = true
        return part_path(part)
      end
    end
    # cookie value not working... load first part of this story
    story = Story.find(story_id)
    story.chapters.each do |chapter|
      current_chapter = chapter
      if chapter.present?
        if admin_user?
          part = chapter.parts.first
        else
          part = chapter.parts.published_parts(story_id).take
        end
        if part.present?
          return part_path(part)
        end
      end
    end
    # no valid parts for this story 
    if admin_user?
      if current_chapter.present?
        new_chapter_part_path(chapter)
      else
        new_story_chapter_path(story)
      end
    else
      about_path
    end

  end   

end
