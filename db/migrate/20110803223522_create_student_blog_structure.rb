class CreateStudentBlogStructure < ActiveRecord::Migration

  def up
    create_table Refinery::StudentBlog::Post.table_name, :id => true do |t|
      t.string :title
      t.text :body
      t.boolean :draft
      t.datetime :published_at
      t.timestamps
    end

    add_index Refinery::StudentBlog::Post.table_name, :id

    create_table Refinery::StudentBlog::Comment.table_name, :id => true do |t|
      t.integer :student_blog_post_id
      t.boolean :spam
      t.string :name
      t.string :email
      t.text :body
      t.string :state
      t.timestamps
    end

    add_index Refinery::StudentBlog::Comment.table_name, :id

    create_table Refinery::StudentBlog::Category.table_name, :id => true do |t|
      t.string :title
      t.timestamps
    end

    add_index Refinery::StudentBlog::Category.table_name, :id

    create_table Refinery::StudentBlog::Categorization.table_name, :id => true do |t|
      t.integer :student_blog_category_id
      t.integer :student_blog_post_id
    end

    add_index Refinery::StudentBlog::Categorization.table_name, [:student_blog_category_id, :student_blog_post_id], :name => 'index_student_blog_categories_student_blog_posts_on_bc_and_bp'
  end

  def down
    Refinery::UserPlugin.destroy_all({:name => "refinerycms_student_blog"})

    Refinery::Page.delete_all({:link_url => "/student_blog"})

    drop_table Refinery::StudentBlog::Post.table_name
    drop_table Refinery::StudentBlog::Comment.table_name
    drop_table Refinery::StudentBlog::Category.table_name
    drop_table Refinery::StudentBlog::Categorization.table_name
  end

end
