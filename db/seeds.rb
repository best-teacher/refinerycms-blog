Refinery::User.all.each do |user|
  if user.plugins.where(:name => 'refinerycms_teacher_blog').blank?
    user.plugins.create(:name => "refinerycms_teacher_blog",
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end if defined?(Refinery::User)

if defined?(Refinery::Page) and !Refinery::Page.exists?(:link_url => '/teacher_blog')
  page = Refinery::Page.create(
    :title => "TeacherBlog",
    :link_url => "/teacher_blog",
    :deletable => false,
    :menu_match => "^/teacher_blogs?(\/|\/.+?|)$"
  )

  Refinery::Pages.default_parts.each do |default_page_part|
    page.parts.create(:title => default_page_part, :body => nil)
  end
end
