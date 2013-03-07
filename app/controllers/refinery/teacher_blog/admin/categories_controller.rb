module Refinery
  module TeacherBlog
    module Admin
      class CategoriesController < ::Refinery::AdminController

        crudify :'refinery/teacher_blog/category',
                :order => 'title ASC'

      end
    end
  end
end
