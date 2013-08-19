module Refinery
  module StudentBlog
    module Admin
      class SettingsController < ::Refinery::AdminController

        def notification_recipients
          @recipients = Refinery::StudentBlog::Comment::Notification.recipients

          if request.post?
            Refinery::StudentBlog::Comment::Notification.recipients = params[:recipients]
            flash[:notice] = t('updated', :scope => 'refinery.student_blog.admin.settings.notification_recipients',
                               :recipients => Refinery::StudentBlog::Comment::Notification.recipients)
            unless request.xhr? or from_dialog?
              redirect_back_or_default(refinery.student_blog_admin_posts_path)
            else
              render :text => "<script type='text/javascript'>parent.window.location = '#{refinery.student_blog_admin_posts_path}';</script>",
                     :layout => false
            end
          end
        end

        def moderation
          enabled = Refinery::StudentBlog::Comment::Moderation.toggle!
          unless request.xhr?
            redirect_back_or_default(refinery.student_blog_admin_posts_path)
          else
            render :json => {:enabled => enabled},
                   :layout => false
          end
        end

        def comments
          enabled = Refinery::StudentBlog::Comment.toggle!
          unless request.xhr?
            redirect_back_or_default(refinery.student_blog_admin_posts_path)
          else
            render :json => {:enabled => enabled},
                   :layout => false
          end
        end

        def teasers
          enabled = Refinery::StudentBlog::Post.teaser_enabled_toggle!
          unless request.xhr?
            redirect_back_or_default(refinery.student_blog_admin_posts_path)
          else
            render :json => {:enabled => enabled},
                   :layout => false
          end
        end

      end
    end
  end
end