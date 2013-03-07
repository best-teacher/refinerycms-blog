module Refinery
  module TeacherBlog
    class TeacherBlogController < ::ApplicationController

      include ControllerHelper

      helper :'refinery/teacher_blog/posts'
      before_filter :set_locale_en
      before_filter :find_page, :find_all_teacher_blog_categories

      protected
        def set_locale_en
          ::I18n.locale=:en
        end

        def find_page
          @page = Refinery::Page.find_by_link_url(Refinery::TeacherBlog.page_url)
        end
    end
  end
end
