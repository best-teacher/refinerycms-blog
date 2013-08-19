module Refinery
  module StudentBlog
    module ControllerHelper
    
      protected
    
        def find_student_blog_post
          unless (@post = Refinery::StudentBlog::Post.find(params[:id])).try(:live?)
            if refinery_user? and current_refinery_user.authorized_plugins.include?("refinerycms_student_blog")
              @post = Refinery::StudentBlog::Post.find(params[:id])
            else
              error_404
            end
          end
        end
    
        def find_all_student_blog_posts
          @posts = Refinery::StudentBlog::Post.live.includes(:comments, :categories).page(params[:page])
        end

        def find_tags
          @tags = Refinery::StudentBlog::Post.tag_counts_on(:tags)
        end
        def find_all_student_blog_categories
          @categories = Refinery::StudentBlog::Category.all
        end
    end
  end
end
