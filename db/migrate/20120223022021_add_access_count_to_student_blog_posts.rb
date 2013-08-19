class AddAccessCountToStudentBlogPosts < ActiveRecord::Migration
  def change
    add_column Refinery::StudentBlog::Post.table_name, :access_count, :integer, :default => 0
    
    add_index Refinery::StudentBlog::Post.table_name, :access_count
    
  end
end