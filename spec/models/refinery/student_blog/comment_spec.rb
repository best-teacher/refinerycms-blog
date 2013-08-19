require 'spec_helper'

module Refinery
  module StudentBlog
    describe Comment do
      context "wiring up" do
        let(:comment) { FactoryGirl.create(:student_blog_comment) }

        it "saves" do
          comment.should_not be_nil
        end

        it "has a student_blog post" do
          comment.post.should_not be_nil
        end
      end
    end
  end
end
