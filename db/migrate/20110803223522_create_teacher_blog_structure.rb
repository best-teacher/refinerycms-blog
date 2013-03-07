class CreateTeacherBlogStructure < ActiveRecord::Migration

  def up
    create_table Refinery::TeacherBlog::Post.table_name, :id => true do |t|
      t.string :title
      t.text :body
      t.boolean :draft
      t.datetime :published_at
      t.timestamps
    end

    add_index Refinery::TeacherBlog::Post.table_name, :id

    create_table Refinery::TeacherBlog::Comment.table_name, :id => true do |t|
      t.integer :teacher_blog_post_id
      t.boolean :spam
      t.string :name
      t.string :email
      t.text :body
      t.string :state
      t.timestamps
    end

    add_index Refinery::TeacherBlog::Comment.table_name, :id

    create_table Refinery::TeacherBlog::Category.table_name, :id => true do |t|
      t.string :title
      t.timestamps
    end

    add_index Refinery::TeacherBlog::Category.table_name, :id

    create_table Refinery::Categorization.table_name, :id => true do |t|
      t.integer :teacher_blog_category_id
      t.integer :teacher_blog_post_id
    end

    add_index Refinery::Categorization.table_name, [:teacher_blog_category_id, :teacher_blog_post_id], :name => 'index_teacher_blog_categories_teacher_blog_posts_on_bc_and_bp'
  end

  def down
    Refinery::UserPlugin.destroy_all({:name => "refinerycms_teacher_blog"})

    Refinery::Page.delete_all({:link_url => "/teacher_blog"})

    drop_table Refinery::TeacherBlog::Post.table_name
    drop_table Refinery::TeacherBlog::Comment.table_name
    drop_table Refinery::Category.table_name
    drop_table Refinery::Categorization.table_name
  end

end
