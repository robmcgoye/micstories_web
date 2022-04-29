module StoriesHelper
  
  def back_to_story_path(story_id)
    last_viewed_part = false
    cookie_name = "story_#{story_id}"
      if !cookies[cookie_name].nil?
        part = Part.find(cookies[cookie_name])
        if part.chapter.story_id == story_id
          last_viewed_part = true
          return part_path(part)
        end
      end
    if !last_viewed_part
      story = Story.find(story_id)
      chapter = story.chapters.first
      if chapter.present?
        part = chapter.parts.first
        if part.present?
          part_path(part)
        else
          if admin_user?
            #add new part....
            new_chapter_part_path(chapter)
          else
            # flash notice an error about not finding story
            about_path
          end
        end
      else
        if admin_user?
          #add new chapter
          new_story_chapter_path(story)
        else
          # flash notice an error about not finding story
          about_path
        end
      end
    end   
  end

end
