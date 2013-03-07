require "spec_helper"

module Refinery
  describe "TeacherBlogCategories" do
    login_refinery_user

    context "has one category and post" do
      before(:each) do
        @post = FactoryGirl.create(:teacher_blog_post, :title => "Refinery CMS teacher_blog post")
        @category = FactoryGirl.create(:teacher_blog_category, :title => "Video Games")
        @post.categories << @category
        @post.save!
      end

      describe "show categories teacher_blog posts" do
        before(:each) { visit refinery.teacher_blog_category_path(@category) }
        it "should displays categories teacher_blog posts" do
          page.should have_content("Refinery CMS teacher_blog post")
          page.should have_content("Video Games")
        end
      end
    end
  end
end
