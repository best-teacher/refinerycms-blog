FactoryGirl.define do
  factory :student_blog_comment, :class => Refinery::StudentBlog::Comment do
    name "Joe Commenter"
    sequence(:email) { |n| "person#{n}@example.com" }
    body "Which one is the best for picking up new shoes?"
    association :post, :factory => :student_blog_post
  
    trait :approved do
      state 'approved'
    end
  
    trait :rejected do
      state 'rejected'
    end
    
    factory :approved_comment, :traits => [:approved]
    factory :rejected_comment, :traits => [:rejected]
  end
end
