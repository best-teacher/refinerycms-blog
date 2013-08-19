module Refinery
  module StudentBlog
    module Admin
      class CategoriesController < ::Refinery::AdminController

        crudify :'refinery/student_blog/category',
                :order => 'title ASC'

      end
    end
  end
end
