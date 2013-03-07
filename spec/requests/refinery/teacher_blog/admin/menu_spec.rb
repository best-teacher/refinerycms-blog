require 'spec_helper'

describe "TeacherBlog menu entry" do
  login_refinery_user

  it "is highlighted when managing the teacher_blog" do
    visit refinery.admin_root_path

    within("#menu") { click_link "TeacherBlog" }

    page.should have_css("a.active", :text => "TeacherBlog")
  end
end
