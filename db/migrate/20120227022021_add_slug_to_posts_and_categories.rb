class AddSlugToPostsAndCategories < ActiveRecord::Migration
  def change
    add_column Refinery::StudentBlog::Post.table_name, :slug, :string
    add_index Refinery::StudentBlog::Post.table_name, :slug

    add_column Refinery::StudentBlog::Category.table_name, :slug, :string
    add_index Refinery::StudentBlog::Category.table_name, :slug
  end
end