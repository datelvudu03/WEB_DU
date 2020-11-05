# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

=begin
2.times do |t|
  user = User.new
  user.email = "test#{t}@example.com"
  user.username = "test_user"
  user.password = "123456789"
  user.password_confirmation = "123456789"
  user.confirmed_at = Time.now
  user.save!
end
=end

user_count = User.count
unless user_count.zero?
  user_count += 1
end


  user = User.new
  user.id = user_count
  user.email = "test#{user_count}@example.com"
  user.username = "test_user"
  user.password = "123456789"
  user.password_confirmation = "123456789"
  user.confirmed_at = Time.now
  user.save!


all_user = User.all.ids

all_user.each do |count|

  20.times do |cat_t|
    Category.create!(title: "Cat #{cat_t}", user_id: count)
  end

  50.times do |tag_t|
    Tag.create!(title: "Tag #{tag_t}", user_id: count)
  end

  398.times do |task_t|
    user_category = Category.where(user_id: count).sample.id
    rand_cat = rand(0..Category.where(user_id: count).count)
    if rand_cat.zero?
      user_category = nil
    end

    num = rand(0..1)
    if num.zero?
      is_done = true
    else
      is_done = false
    end

    @user_tag = Tag.where(user_id: count).sample(rand(0..10))
    rand_cat = rand(0..Tag.where(user_id: count).count)
    if rand_cat.zero?
      @user_tag = nil
    end


    if @user_tag.nil?
      Task.create!(deadline_at: Time.at(rand * Time.now.to_i) ,title: "Task #{task_t + 1}", category_id: user_category, is_done: is_done, user_id: count)
    else
      Task.create!(deadline_at: Time.at(rand * Time.now.to_i), title: "Task #{task_t + 1}", category_id: user_category, is_done: is_done, user_id: count, tags: @user_tag)
    end
  end

  Task.create!(deadline_at: Time.at(rand * Time.now.to_i),title: "Task 399", is_done: false, user_id: count)
  Task.create!(deadline_at: Time.at(rand * Time.now.to_i),title: "Task 400", category_id: Category.where(user_id: count).sample.id, is_done: false, user_id: count)

end
