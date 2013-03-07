class AddPrimaryKeyToTeacherBlogCategorizations < ActiveRecord::Migration
  def up
    unless Refinery::TeacherBlog::Categorization.column_names.include?("id")
      add_column Refinery::TeacherBlog::Categorization.table_name, :id, :primary_key
    end
  end

  def down
    if Refinery::TeacherBlog::Categorization.column_names.include?("id")
      remove_column Refinery::TeacherBlog::Categorization.table_name, :id
    end
  end
end

