module Refinery
  module StudentBlog
    class Categorization < ActiveRecord::Base

      self.table_name = 'refinery_student_blog_categories_student_blog_posts'
      belongs_to :student_blog_post, :class_name => 'Refinery::StudentBlog::Post', :foreign_key => :student_blog_post_id
      belongs_to :student_blog_category, :class_name => 'Refinery::StudentBlog::Category', :foreign_key => :student_blog_category_id
      
      attr_accessible :student_blog_category_id, :student_blog_post_id
    end
  end
end