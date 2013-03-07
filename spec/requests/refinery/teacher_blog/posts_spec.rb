require "spec_helper"

module Refinery
  describe "TeacherBlog::Posts" do
    login_refinery_user
  
    context "when has teacher_blog posts" do    
      let!(:teacher_blog_post) { FactoryGirl.create(:teacher_blog_post, :title => "Refinery CMS teacher_blog post") }
    
      it "should display teacher_blog post" do
        visit refinery.teacher_blog_post_path(teacher_blog_post)
        
        page.should have_content(teacher_blog_post.title)
      end
    
      it "should display the teacher_blog rss feed" do
        get refinery.teacher_blog_rss_feed_path
        
        response.should be_success
        response.content_type.should eq("application/rss+xml")
      end
    end
      
    describe "list tagged posts" do    
      context "when has tagged teacher_blog posts" do      
        before(:each) do
          @tag_name = "chicago"
          @post = FactoryGirl.create(:teacher_blog_post,
                                          :title => "I Love my city",
                                          :tag_list => @tag_name)
          @tag = ::Refinery::TeacherBlog::Post.tag_counts_on(:tags).first          
        end
        it "should have one tagged post" do
          visit refinery.teacher_blog_tagged_posts_path(@tag.id, @tag_name.parameterize)
          
          page.should have_content(@tag_name)
          page.should have_content(@post.title)
        end
      end
    end
    
    describe "#show" do
      context "when has no comments" do
        let(:teacher_blog_post) { FactoryGirl.create(:teacher_blog_post) }
        
        it "should display the teacher_blog post" do
          visit refinery.teacher_blog_post_path(teacher_blog_post)
          page.should have_content(teacher_blog_post.title)
          page.should have_content(teacher_blog_post.body)
        end
      end
      context "when has approved comments" do
        let(:approved_comment) { FactoryGirl.create(:approved_comment) }
        
        it "should display the comments" do
          visit refinery.teacher_blog_post_path(approved_comment.post)
          
          page.should have_content(approved_comment.body)
          page.should have_content("Posted by #{approved_comment.name}")
        end
      end
      context "when has rejected comments" do
        let(:rejected_comment) { FactoryGirl.create(:rejected_comment) }
        
        it "should not display the comments" do          
          visit refinery.teacher_blog_post_path(rejected_comment.post)
          
          page.should_not have_content(rejected_comment.body)
        end
      end
      context "when has new comments" do
        let(:teacher_blog_comment) { FactoryGirl.create(:teacher_blog_comment) }
        
        it "should not display the comments" do
          visit refinery.teacher_blog_post_path(teacher_blog_comment.post)
          
          page.should_not have_content(teacher_blog_comment.body)
        end
      end

      context "when posting comments" do
        let(:teacher_blog_post) { Factory(:teacher_blog_post) }
        let(:name) { "pete" }
        let(:email) { "pete@mcawesome.com" }
        let(:body) { "Witty comment." }

        before do
          visit refinery.teacher_blog_post_path(teacher_blog_post)

          fill_in "Name", :with => name
          fill_in "Email", :with => email
          fill_in "Message", :with => body
          click_button "Send comment"
        end

        it "creates the comment" do
          comment = teacher_blog_post.reload.comments.last

          comment.name.should eq(name)
          comment.email.should eq(email)
          comment.body.should eq(body)
        end
      end

      context "post popular" do
        let(:teacher_blog_post) { FactoryGirl.create(:teacher_blog_post) }
        let(:teacher_blog_post2) { FactoryGirl.create(:teacher_blog_post) }

        before do
          visit refinery.teacher_blog_post_path(teacher_blog_post)
        end

        it "should increment access count" do
          teacher_blog_post.reload.access_count.should eq(1)
          visit refinery.teacher_blog_post_path(teacher_blog_post)
          teacher_blog_post.reload.access_count.should eq(2)
        end

        it "should be most popular" do
          Refinery::TeacherBlog::Post.popular(2).first.should eq(teacher_blog_post)
        end
      end

      context "post recent" do
        let(:teacher_blog_post) { FactoryGirl.create(:teacher_blog_post) }
        let(:teacher_blog_post2) { FactoryGirl.create(:teacher_blog_post) }

        before do
          visit refinery.teacher_blog_post_path(teacher_blog_post2)
          visit refinery.teacher_blog_post_path(teacher_blog_post)
        end

        it "should be the most recent" do
          Refinery::TeacherBlog::Post.recent(2).first.should eq(teacher_blog_post2)
        end
      end

    end

    describe "#show draft preview" do
      let(:teacher_blog_post) { FactoryGirl.create(:teacher_blog_post_draft) }
      context "when logged in as admin" do        
        it "should display the draft notification" do
          visit refinery.teacher_blog_post_path(teacher_blog_post)
          
          page.should have_content('This page is NOT live for public viewing.')
        end
      end
      context "when not logged in as an admin" do
        before(:each) { visit refinery.destroy_refinery_user_session_path }
        
        it "should not display the teacher_blog post" do
          visit refinery.teacher_blog_post_path(teacher_blog_post)
          
          page.should have_content("The page you were looking for doesn't exist (404)")
        end
      end
    end
  end
end
