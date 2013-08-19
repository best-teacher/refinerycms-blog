require 'spec_helper'

describe "StudentBlog menu entry" do
  login_refinery_user

  it "is highlighted when managing the student_blog" do
    visit refinery.admin_root_path

    within("#menu") { click_link "StudentBlog" }

    page.should have_css("a.active", :text => "StudentBlog")
  end
end
