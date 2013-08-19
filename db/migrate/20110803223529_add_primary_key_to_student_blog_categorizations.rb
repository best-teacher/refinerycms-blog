class AddPrimaryKeyToStudentBlogCategorizations < ActiveRecord::Migration
  def up
    unless Refinery::StudentBlog::Categorization.column_names.include?("id")
      add_column Refinery::StudentBlog::Categorization.table_name, :id, :primary_key
    end
  end

  def down
    if Refinery::StudentBlog::Categorization.column_names.include?("id")
      remove_column Refinery::StudentBlog::Categorization.table_name, :id
    end
  end
end

