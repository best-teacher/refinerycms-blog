module Refinery
  module StudentBlog
    module Admin
      class PostsController < ::Refinery::AdminController

        crudify :'refinery/student_blog/post',
                :order => 'published_at DESC'

        before_filter :find_all_categories,
                      :only => [:new, :edit, :create, :update]

        before_filter :check_category_ids, :only => :update

        def uncategorized
          @posts = Refinery::StudentBlog::Post.uncategorized.page(params[:page])
        end

        def tags
          if ActiveRecord::Base.connection.adapter_name.downcase == 'postgresql'
            op = '~*'
            wildcard = '.*'
          else
            op = 'LIKE'
            wildcard = '%'
          end

          @tags = Refinery::StudentBlog::Post.tag_counts_on(:tags).where(
              ["tags.name #{op} ?", "#{wildcard}#{params[:term].to_s.downcase}#{wildcard}"]
            ).map { |tag| {:id => tag.id, :value => tag.name}}
          render :json => @tags.flatten
        end

        def new
          @post = ::Refinery::StudentBlog::Post.new(:author => current_refinery_user)
        end

        def create
          # if the position field exists, set this object as last object, given the conditions of this class.
          if Refinery::StudentBlog::Post.column_names.include?("position")
            params[:post].merge!({
              :position => ((Refinery::StudentBlog::Post.maximum(:position, :conditions => "")||-1) + 1)
            })
          end

          if (@post = Refinery::StudentBlog::Post.create(params[:post])).valid?
            (request.xhr? ? flash.now : flash).notice = t(
              'refinery.crudify.created',
              :what => "'#{@post.title}'"
            )

            unless from_dialog?
              unless params[:continue_editing] =~ /true|on|1/
                redirect_back_or_default(refinery.student_blog_admin_posts_path)
              else
                unless request.xhr?
                  redirect_to :back
                else
                  render :partial => "/shared/message"
                end
              end
            else
              render :text => "<script>parent.window.location = '#{refinery.student_blog_admin_posts_url}';</script>"
            end
          else
            unless request.xhr?
              render :action => 'new'
            else
              render :partial => "/refinery/admin/error_messages",
                     :locals => {
                       :object => @post,
                       :include_object_name => true
                     }
            end
          end
        end

      protected
        def find_all_categories
          @categories = Refinery::StudentBlog::Category.find(:all)
        end

        def check_category_ids
          params[:post][:category_ids] ||= []
        end
      end
    end
  end
end
