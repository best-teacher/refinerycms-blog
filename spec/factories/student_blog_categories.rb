FactoryGirl.define do
  factory :student_blog_category, :class => Refinery::StudentBlog::Category do
    sequence(:title) { |n| "Shopping #{n}" }
  end
end
