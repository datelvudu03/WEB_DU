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
require 'faker'

def add_date
  DateTime.now + (rand * 31)
end

def add_color
  Faker::Color.rgb_color.join(', ')
end

### create user
user_count = User.count
user = User.new
user.id = user_count
user.email = "test#{user_count}@example.com"
user.username = 'test_user'
user.password = '123456789'
user.password_confirmation = '123456789'
user.confirmed_at = Time.now
user.save!


all_user = User.all.ids

all_user.each do |count|
  unless User.find(count).tasks.count >= 400
    20.times do
      Category.create!(title: Faker::Book.publisher, user_id: count, color: add_color)
    end
  # "Cat #{cat_t}"

  50.times do
    Tag.create!(title: Faker::Book.genre, user_id: count, color: add_color)
  end
  #"Tag #{tag_t}"
  398.times do
    user_category = Category.where(user_id: count).sample.id
    rand_cat = rand(0..Category.where(user_id: count).count)
    user_category = nil if rand_cat.zero?

    num = rand(0..1)
    is_done = if num.zero?
                true
              else
                false
              end

    @user_tag = Tag.where(user_id: count).sample(rand(0..10))
    rand_cat = rand(0..Tag.where(user_id: count).count)
    @user_tag = nil if rand_cat.zero?


    if @user_tag.nil?
      Task.create!(deadline_at: add_date, title: Faker::Quote.famous_last_words, note: Faker::Quote.famous_last_words,
                   category_id: user_category, is_done: is_done, user_id: count)
    else
      Task.create!(deadline_at: add_date, title: Faker::Quote.famous_last_words, note: Faker::Quote.famous_last_words,
                   category_id: user_category, is_done: is_done, user_id: count, tags: @user_tag)
    end
  end

  Task.create!(deadline_at: add_date,title: Faker::Quote.famous_last_words, note: Faker::Quote.famous_last_words,
               is_done: false, user_id: count)
  Task.create!(deadline_at: add_date,title: Faker::Quote.famous_last_words, note: Faker::Quote.famous_last_words,
               category_id: Category.where(user_id: count).sample.id, is_done: false, user_id: count)
  end
end


