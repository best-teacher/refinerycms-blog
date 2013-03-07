class AddCustomTeaserFieldToTeacherBlogPosts < ActiveRecord::Migration
  def change
    add_column Refinery::TeacherBlog::Post.table_name, :custom_teaser, :text
  end
end

