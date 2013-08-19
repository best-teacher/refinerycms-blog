module Refinery
  class StudentBlogGenerator < Rails::Generators::Base

    source_root File.expand_path("../templates", __FILE__)

    def generate_student_blog_initializer
      template "config/initializers/refinery/student_blog.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "student_blog.rb")
    end

    def rake_db
      rake("refinery_student_blog:install:migrations")
      rake("refinery_settings:install:migrations")
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS StudentBlog engine
Refinery::StudentBlog::Engine.load_seed
        EOH
      end
    end

  end
end
