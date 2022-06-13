module PartsHelper

  def get_next_part(current_part)
    next_part = Part.next_part( current_part.chapter_id, current_part.sort_order, admin_user? ).take
    if !next_part.present?
      next_chapter = Chapter.next_chapter(current_part.chapter.story_id, current_part.chapter.sort_order).take  
      begin 
        if next_chapter.present?
          next_part = Part.first_part(next_chapter.id, admin_user?)                    
        end
        if !next_part.present? && next_chapter.present?
          next_chapter = Chapter.next_chapter(current_part.chapter.story_id, next_chapter.sort_order).take
        end  
      end until next_part.present? || !next_chapter.present?
    end 
    next_part
  end

  def get_prev_part(current_part)
    prev_part = Part.prev_part(current_part.chapter_id, current_part.sort_order, admin_user?).take
    if !prev_part.present?
      prev_chapter = Chapter.prev_chapter(current_part.chapter.story_id, current_part.chapter.sort_order ).take
      begin  
        if prev_chapter.present?
          prev_part = Part.last_part(prev_chapter.id, admin_user?)
        end
        if !prev_part.present? && prev_chapter.present?
          prev_chapter = Chapter.prev_chapter(current_part.chapter.story_id, prev_chapter.sort_order ).take
        end
      end until prev_part.present? || !prev_chapter.present?
    end 
    prev_part
  end

end
