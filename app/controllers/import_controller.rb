class ImportController < ApplicationController
  before_action :require_admin_user
  
  def index
  end

  def add_data
    mysql_opts = mysql_options_params
    if !mysql_opts[:host].present?
      flash.now[:alert] = "Host cannot be blank"      
    elsif !mysql_opts[:database].present?
      flash.now[:alert] = "database cannot be blank"      
    elsif !mysql_opts[:user].present?
      flash.now[:alert] = "User cannot be blank"      
    elsif !mysql_opts[:password].present?
      flash.now[:alert] = "Password cannot be blank"      
    else
      client = connect_mysql(mysql_opts)
    end
    if client.present? && !client.closed?
      @records_imported = {stories: 0, characters: 0, chapters: 0, parts: 0, posts: 0, skipped: 0}
      @skipped_records = []
      # get all of the stories to import (currently it is 1)
      mysql_stories = client.query("SELECT * FROM stories")    
      mysql_stories.each do |row|
        story = Story.create!( 
                long_title: convert_string(row["storyTitleFull"]), 
                short_title: convert_string(row["storyTitleShort"]),
                published: :true,
                sort_order: row["isort"]
              )
        @records_imported[:stories] += 1            
        # get all of the characters 
        mysql_characters = client.query("SELECT * FROM people")
        mysql_characters.each do |r| 
          char = story.characters.create!( 
                  full_name: convert_string(r["fullname"]), 
                  chat_name: convert_string(r["postname"]), 
                  description: convert_string(r["description"]),
                  sort_order: r["isort"]
                )
          @records_imported[:characters] += 1            
        end
        # get all of the chapters for this story
        mysql_chapters = client.query("SELECT * FROM chapters WHERE storyID = #{row["iID"]} ORDER BY isort ASC")
        mysql_chapters.each do |cr| 
          chapter = story.chapters.create!( 
                    title: convert_string(cr["chapterTitle"]),
                    subtitle: "",
                    sort_order: cr["isort"]
                  )
          @records_imported[:chapters] += 1            
          # get all of the parts for this chapter.
          mysql_parts = client.query("SELECT * FROM parts WHERE chapterID = #{cr["iID"]} ORDER BY isort ASC")
          mysql_parts.each do |pr|

            if convert_string(pr["partTitle"]).blank?
              byebug
            end

            part = chapter.parts.create!(
                    title: convert_string(pr["partTitle"]), 
                    subtitle: convert_string(pr["title"]),
                    published: :true,
                    chat_title: convert_string(pr["posttitle"]),
                    publish_at: get_published_at(pr["dtspost"]),
                    content: convert_string(pr["content"]),
                    sort_order: pr["isort"]
                  )
            @records_imported[:parts] += 1
            # get all of the posts for this part.
            mysql_posts = client.query("SELECT * FROM posts WHERE partid = #{pr["iID"]} ORDER BY isort ASC")
            mysql_posts.each do |ptr|
              # lookup the mysql people.postname
              post_name = ""
              mysql_post_name = client.query("SELECT postname FROM people WHERE iID = #{ptr["peopleid"]}")
              mysql_post_name.each { |pnr| post_name = convert_string(pnr["postname"]) }
              #
              character_id = get_id_from_postname(post_name)
              if character_id.present?
                post = part.posts.create!(
                        message: convert_string(ptr["content"]),
                        published: :true,
                        publish_at: get_published_at(ptr["dtspost"]),
                        character_id: get_id_from_postname(post_name),
                        sort_order: ptr["isort"]                    
                      )
                @records_imported[:posts] += 1
              else
                @records_imported[:skipped] += 1
                @skipped_records << ptr
              end
            end
          end 
        end
      end 
      client.close
    else
      render :index
    end
  end 
  
  private

  def get_id_from_postname(post_name)
      cc = Character.find_by(chat_name: post_name)
      if cc.present?
        cc.id
      else
        nil
      end
  end

  def get_published_at(pub_at)
    Date.today
  end

  def convert_string(encoded_string)
    decoded_string = ""
    if !encoded_string.nil?
      decoded_string = (CGI.unescape(encoded_string)).force_encoding('iso-8859-1').encode('utf-8')
    end
    decoded_string
  end

  def connect_mysql(options)
    begin
      Mysql2::Client.new( 
        :host => options[:host],
        :username => options[:user],
        :password => options[:password],
        :database => options[:database])
      rescue => exception
        flash[:alert] = "Error connecting to the mySQL server or bad user password"
        return nil
      end
  end

  def mysql_options_params
    params.require(:mysql_options).permit(:host, :database, :user, :password)
  end

end
