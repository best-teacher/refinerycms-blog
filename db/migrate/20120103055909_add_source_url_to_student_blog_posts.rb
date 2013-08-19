class AddSourceUrlToStudentBlogPosts < ActiveRecord::Migration
  def change
    add_column Refinery::StudentBlog::Post.table_name, :source_url, :string
    add_column Refinery::StudentBlog::Post.table_name, :source_url_title, :string
    
  end
end
