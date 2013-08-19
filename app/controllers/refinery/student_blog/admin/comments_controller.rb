module Refinery
  module StudentBlog
    module Admin
      class CommentsController < ::Refinery::AdminController

        crudify :'refinery/student_blog/comment',
                :title_attribute => :name,
                :order => 'published_at DESC'

        def index
          @comments = Refinery::StudentBlog::Comment.unmoderated.page(params[:page])

          render :action => 'index'
        end

        def approved
          unless params[:id].present?
            @comments = Refinery::StudentBlog::Comment.approved.page(params[:page])

            render :action => 'index'
          else
            @comment = Refinery::StudentBlog::Comment.find(params[:id])
            @comment.approve!
            flash[:notice] = t('approved', :scope => 'refinery.student_blog.admin.comments', :author => @comment.name)

            redirect_to refinery.url_for(:action => params[:return_to] || 'index', :id => nil)
          end
        end

        def rejected
          unless params[:id].present?
            @comments = Refinery::StudentBlog::Comment.rejected.page(params[:page])

            render :action => 'index'
          else
            @comment = Refinery::StudentBlog::Comment.find(params[:id])
            @comment.reject!
            flash[:notice] = t('rejected', :scope => 'refinery.student_blog.admin.comments', :author => @comment.name)

            redirect_to refinery.url_for(:action => params[:return_to] || 'index', :id => nil)
          end
        end

      end
    end
  end
end
