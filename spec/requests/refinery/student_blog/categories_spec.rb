require "spec_helper"

module Refinery
  describe "StudentBlogCategories" do
    login_refinery_user

    context "has one category and post" do
      before(:each) do
        @post = FactoryGirl.create(:student_blog_post, :title => "Refinery CMS student_blog post")
        @category = FactoryGirl.create(:student_blog_category, :title => "Video Games")
        @post.categories << @category
        @post.save!
      end

      describe "show categories student_blog posts" do
        before(:each) { visit refinery.student_blog_category_path(@category) }
        it "should displays categories student_blog posts" do
          page.should have_content("Refinery CMS student_blog post")
          page.should have_content("Video Games")
        end
      end
    end
  end
end
