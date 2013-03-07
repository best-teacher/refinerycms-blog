class AddUserIdToTeacherBlogPosts < ActiveRecord::Migration

  def change
    add_column Refinery::TeacherBlog::Post.table_name, :user_id, :integer
  end

end