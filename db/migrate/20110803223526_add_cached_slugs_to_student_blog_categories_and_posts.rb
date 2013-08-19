class AddCachedSlugsToStudentBlogCategoriesAndPosts < ActiveRecord::Migration
  def change
    add_column Refinery::StudentBlog::Category.table_name, :cached_slug, :string
    add_column Refinery::StudentBlog::Post.table_name, :cached_slug, :string
  end
end
