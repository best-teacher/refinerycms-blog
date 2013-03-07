class AddSourceUrlToTeacherBlogPosts < ActiveRecord::Migration
  def change
    add_column Refinery::TeacherBlog::Post.table_name, :source_url, :string
    add_column Refinery::TeacherBlog::Post.table_name, :source_url_title, :string
    
  end
end
