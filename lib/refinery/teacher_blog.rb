require 'refinerycms-core'
require 'refinerycms-settings'
require 'filters_spam'
require 'rails_autolink'

module Refinery
  autoload :TeacherBlogGenerator, 'generators/refinery/teacher_blog/teacher_blog_generator'

  module TeacherBlog
    require 'refinery/teacher_blog/engine'
    require 'refinery/teacher_blog/configuration'

    autoload :Version, 'refinery/teacher_blog/version'
    autoload :Tab, 'refinery/teacher_blog/tabs'

    class << self
      attr_writer :root
      attr_writer :tabs

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def tabs
        @tabs ||= []
      end

      def version
        ::Refinery::TeacherBlog::Version.to_s
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
  end
end
