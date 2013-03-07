module Refinery
  module TeacherBlog
    module ControllerHelper
    
      protected
    
        def find_teacher_blog_post
          unless (@post = Refinery::TeacherBlog::Post.find(params[:id])).try(:live?)
            if refinery_user? and current_refinery_user.authorized_plugins.include?("refinerycms_teacher_blog")
              @post = Refinery::TeacherBlog::Post.find(params[:id])
            else
              error_404
            end
          end
        end
    
        def find_all_teacher_blog_posts
          @posts = Refinery::TeacherBlog::Post.live.includes(:comments, :categories).page(params[:page])
        end

        def find_tags
          @tags = Refinery::TeacherBlog::Post.tag_counts_on(:tags)
        end
        def find_all_teacher_blog_categories
          @categories = Refinery::TeacherBlog::Category.all
        end
    end
  end
end
