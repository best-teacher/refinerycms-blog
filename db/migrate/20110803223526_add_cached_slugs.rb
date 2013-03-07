class AddCachedSlugs < ActiveRecord::Migration
  def change
    add_column Refinery::TeacherBlog::Category.table_name, :cached_slug, :string
    add_column Refinery::TeacherBlog::Post.table_name, :cached_slug, :string
  end
end
