module Refinery
  module StudentBlog
    class Category < ActiveRecord::Base
      extend FriendlyId
      friendly_id :title, :use => [:slugged]

      has_many :categorizations, :dependent => :destroy, :foreign_key => :student_blog_category_id
      has_many :posts, :through => :categorizations, :source => :student_blog_post

      acts_as_indexed :fields => [:title]

      validates :title, :presence => true, :uniqueness => true

      attr_accessible :title

      def post_count
        posts.select(&:live?).count
      end

      # how many items to show per page
      self.per_page = Refinery::StudentBlog.posts_per_page

    end
  end
end
