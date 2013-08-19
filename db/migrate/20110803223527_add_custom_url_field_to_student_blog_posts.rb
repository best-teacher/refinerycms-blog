class AddCustomUrlFieldToStudentBlogPosts < ActiveRecord::Migration
  def change
    add_column Refinery::StudentBlog::Post.table_name, :custom_url, :string
  end
end
