class AddCustomUrlFieldToTeacherBlogPosts < ActiveRecord::Migration
  def change
    add_column Refinery::TeacherBlog::Post.table_name, :custom_url, :string
  end
end
