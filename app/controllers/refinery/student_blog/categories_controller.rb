module Refinery
  module StudentBlog
    class CategoriesController < StudentBlogController

      def show
        @category = Refinery::StudentBlog::Category.find(params[:id])
        @posts = @category.posts.live.includes(:comments, :categories).page(params[:page])
      end

    end
  end
end
