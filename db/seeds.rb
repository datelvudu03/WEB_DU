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

# ja vim ze tohle je prasarna ale co :-D

=begin
user_count = User.count

max_count = user_count + 1

user_count.times do |count|
  count += 1
  unless Category.where(user_id: count).exists?
    Category.create!(title: "Osobní", user_id: count)
    Category.create!(title: "Škola", user_id: count)
    Category.create!(title: "Práce", user_id: count)
  end

  unless Tag.where(user_id: count).exists?
    Tag.create!(title: "UCL", user_id: count)
    Tag.create!(title: "JSE", user_id: count)
    Tag.create!(title: "WEB", user_id: count)
    Tag.create!(title: "3DT", user_id: count)
    Tag.create!(title: "PR1", user_id: count)
    Tag.create!(title: "PES", user_id: count)
    Tag.create!(title: "Nákupy", user_id: count)
    Tag.create!(title: "Wishlist", user_id: count)
  end


  unless Task.where(user_id: count).exists?
    Task.create!(title: "Toto je jednoduchý úkol", category_id: nil, is_done: false, user_id: count)
    Task.create!(title: "Toto je už dokončený úkol", category_id: nil, is_done: true, user_id: count)

    category_for_task = Category.find_by(user_id: count, title: "Osobní")
    Task.create!(title: "Nakoupit na večeři", category_id: category_for_task.id, is_done: false, user_id: count)

    category_for_task2 = Category.find_by(user_id: count, title: "Škola")
    Task.create!(title: "Udělat semestrální práci z předmětu WEB", category_id: category_for_task2.id, is_done: false, user_id: count)

    task_tag = Task.find_by(user_id: count, title: "Nakoupit na večeři")
    tag_tag = Tag.find_by(user_id: count, title: "Nákupy")
    TagAssociation.create!(tag_id: tag_tag.id, task_id: task_tag.id)

    task_tag = Task.find_by(user_id: count, title: "Udělat semestrální práci z předmětu WEB")
    tag_tag = Tag.find_by(user_id: count, title: "UCL")
    TagAssociation.create!(tag_id: tag_tag.id, task_id: task_tag.id)

    task_tag = Task.find_by(user_id: count, title: "Udělat semestrální práci z předmětu WEB")
    tag_tag = Tag.find_by(user_id: count, title: "WEB")
    TagAssociation.create!(tag_id: tag_tag.id, task_id: task_tag.id)
  end


end
=end