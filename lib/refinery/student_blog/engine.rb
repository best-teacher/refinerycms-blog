module Refinery
  module StudentBlog
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::StudentBlog

      initializer "register refinerycms_student_blog plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinerycms_student_blog"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.student_blog_admin_posts_path }
          plugin.menu_match = /refinery\/student_blog\/?(posts|comments|categories)?/
          plugin.activity = { :class_name => :'refinery/student_blog/post' }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::StudentBlog)
      end
    end
  end
end
