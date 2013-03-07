module Refinery
  module TeacherBlog
    class CategoriesController < TeacherBlogController

      def show
        @category = Refinery::TeacherBlog::Category.find(params[:id])
        @posts = @category.posts.live.includes(:comments, :categories).page(params[:page])
      end

    end
  end
end
