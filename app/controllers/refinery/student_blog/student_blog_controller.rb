module Refinery
  module StudentBlog
    class StudentBlogController < ::ApplicationController

      include ControllerHelper

      helper :'refinery/student_blog/posts'
      before_filter :set_locale_ja
      before_filter :find_page, :find_all_student_blog_categories

      protected
        def set_locale_en
          ::I18n.locale=:ja
        end

        def find_page
          @page = Refinery::Page.find_by_link_url(Refinery::StudentBlog.page_url)
        end
    end
  end
end
