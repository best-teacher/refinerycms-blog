FactoryGirl.define do
  factory :teacher_blog_category, :class => Refinery::TeacherBlog::Category do
    sequence(:title) { |n| "Shopping #{n}" }
  end
end
