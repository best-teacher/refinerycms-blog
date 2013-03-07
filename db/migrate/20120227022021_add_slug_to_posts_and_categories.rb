class AddSlugToPostsAndCategories < ActiveRecord::Migration
  def change
    add_column Refinery::TeacherBlog::Post.table_name, :slug, :string
    add_index Refinery::TeacherBlog::Post.table_name, :slug

    add_column Refinery::TeacherBlog::Category.table_name, :slug, :string
    add_index Refinery::TeacherBlog::Category.table_name, :slug
  end
end