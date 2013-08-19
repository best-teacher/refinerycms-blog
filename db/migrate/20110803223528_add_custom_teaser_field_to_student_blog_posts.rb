class AddCustomTeaserFieldToStudentBlogPosts < ActiveRecord::Migration
  def change
    add_column Refinery::StudentBlog::Post.table_name, :custom_teaser, :text
  end
end

