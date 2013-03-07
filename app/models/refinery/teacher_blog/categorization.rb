module Refinery
  module TeacherBlog
    class Categorization < ActiveRecord::Base

      self.table_name = 'refinery_teacher_blog_categories_teacher_blog_posts'
      belongs_to :teacher_blog_post, :class_name => 'Refinery::TeacherBlog::Post', :foreign_key => :teacher_blog_post_id
      belongs_to :teacher_blog_category, :class_name => 'Refinery::TeacherBlog::Category', :foreign_key => :teacher_blog_category_id
      
      attr_accessible :teacher_blog_category_id, :teacher_blog_post_id
    end
  end
end