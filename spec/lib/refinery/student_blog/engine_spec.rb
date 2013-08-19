require 'spec_helper'

module Refinery
  module StudentBlog
    describe Engine do
      describe "plugin activity" do
        let(:activity) do
          Refinery::Plugins.registered.find_by_name("refinerycms_student_blog").activity.first
        end

        it "sets the correct path for activity entries" do
          activity.url.should eq("refinery.edit_student_blog_admin_post_path")
        end
      end

      describe ".load_seed" do
        it "is idempotent" do
          Engine.load_seed
          Engine.load_seed

          Refinery::Page.where(:link_url => '/student_blog').count.should eq(1)
        end
      end
    end
  end
end
