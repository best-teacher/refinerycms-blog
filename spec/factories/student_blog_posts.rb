FactoryGirl.define do
  factory :student_blog_post, :class => Refinery::StudentBlog::Post do
    sequence(:title) { |n| "Top #{n} Shopping Centers in Chicago" }
    body "These are the top ten shopping centers in Chicago. You're going to read a long student_blog post about them. Come to peace with it."
    draft false
    tag_list "chicago, shopping, fun times"
    published_at Time.now
    
    factory :student_blog_post_draft do
      draft true
    end
  end
end
