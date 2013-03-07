module Refinery
  module TeacherBlog
    class CommentMailer < ActionMailer::Base

      def notification(comment, request)
        @comment = comment
        mail :subject => TeacherBlog::Comment::Notification.subject,
             :to => TeacherBlog::Comment::Notification.recipients,
             :from => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>"
      end

    end
  end
end
