module Refinery
  module TeacherBlog
    module PostsHelper
      def next_or_previous?(post)
        post.next.present? or post.prev.present?
      end

      def teacher_blog_post_teaser_enabled?
        Refinery::TeacherBlog::Post.teasers_enabled?
      end

      def teacher_blog_post_teaser(post)
        if post.respond_to?(:custom_teaser) && post.custom_teaser.present?
         post.custom_teaser.html_safe
        else
         truncate(post.body, {
           :length => Refinery::TeacherBlog.post_teaser_length,
           :preserve_html_tags => true
          }).html_safe
        end
      end

      def teacher_blog_archive_widget(dates=teacher_blog_archive_dates)
        ArchiveWidget.new(dates, self).display
      end

      def teacher_blog_archive_dates(cutoff=Time.now.beginning_of_month)
        Refinery::TeacherBlog::Post.published_dates_older_than(cutoff)
      end

      def teacher_blog_new_comment_path(post)
        "/teacher_blog/#{post.slug_or_id}/comments"
      end
      def teacher_blog_category_path(cat)
        "/teacher_blog/categories/#{cat.slug.empty? ? cat.id : cat.slug}"
      end
      def teacher_blog_post_path(post)
        post.path
      end
      def teacher_blog_root_path
        "/teacher_blog"
      end
      def teacher_blog_rss_feed_path
        "/teacher_blog/feed.rss"
      end

      class ArchiveWidget
        delegate :t, :link_to, :refinery, :render, :to => :view_context
        attr_reader :view_context

        def initialize(dates, view_context, cutoff=3.years.ago.end_of_year)
          @recent_dates, @old_dates = dates.sort_by {|date| -date.to_i }.
            partition {|date| date > cutoff }

          @view_context = view_context
        end

        def recent_links
          @recent_dates.group_by {|date| [date.year, date.month] }.
            map {|(year, month), dates| recent_link(year, month, dates.count) }
        end

        def recent_link(year, month, count)
          link_to "#{t("date.month_names")[month]} #{year} (#{count})",
            refinery.teacher_blog_archive_posts_path(:year => year, :month => month)
        end

        def old_links
          @old_dates.group_by {|date| date.year }.
            map {|year, dates| old_link(year, dates.size) }
        end

        def old_link(year, count)
          link_to "#{year} (#{count})", refinery.teacher_blog_archive_posts_path(:year => year)
        end

        def links
          recent_links + old_links
        end

        def display
          return "" if links.empty?
          render "refinery/teacher_blog/widgets/teacher_blog_archive", :links => links
        end
      end
    end
  end
end
