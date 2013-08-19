module Refinery
  module StudentBlog
    class CommentMailer < ActionMailer::Base

      def notification(comment, request)
        @comment = comment
        mail :subject => StudentBlog::Comment::Notification.subject,
             :to => StudentBlog::Comment::Notification.recipients,
             :from => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>"
      end

    end
  end
end
