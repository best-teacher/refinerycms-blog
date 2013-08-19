require 'refinerycms-core'
require 'refinerycms-settings'
require 'filters_spam'
require 'rails_autolink'

module Refinery
  autoload :StudentBlogGenerator, 'generators/refinery/student_blog/student_blog_generator'

  module StudentBlog
    require 'refinery/student_blog/engine'
    require 'refinery/student_blog/configuration'

    autoload :Version, 'refinery/student_blog/version'
    autoload :Tab, 'refinery/student_blog/tabs'

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
        ::Refinery::StudentBlog::Version.to_s
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
  end
end
