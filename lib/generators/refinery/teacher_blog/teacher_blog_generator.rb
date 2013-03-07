module Refinery
  class TeacherBlogGenerator < Rails::Generators::Base

    source_root File.expand_path("../templates", __FILE__)

    def generate_teacher_blog_initializer
      template "config/initializers/refinery/teacher_blog.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "teacher_blog.rb")
    end

    def rake_db
      rake("refinery_teacher_blog:install:migrations")
      rake("refinery_settings:install:migrations")
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS TeacherBlog engine
Refinery::TeacherBlog::Engine.load_seed
        EOH
      end
    end

  end
end
