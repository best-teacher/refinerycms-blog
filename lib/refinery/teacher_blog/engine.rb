module Refinery
  module TeacherBlog
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::TeacherBlog

      initializer "register refinerycms_teacher_blog plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinerycms_teacher_blog"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.teacher_blog_admin_posts_path }
          plugin.menu_match = /refinery\/teacher_blog\/?(posts|comments|categories)?/
          plugin.activity = { :class_name => :'refinery/teacher_blog/post' }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::TeacherBlog)
      end
    end
  end
end
