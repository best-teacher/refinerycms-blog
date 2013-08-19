class AddUserIdToStudentBlogPosts < ActiveRecord::Migration

  def change
    add_column Refinery::StudentBlog::Post.table_name, :user_id, :integer
  end

end