class MainPagesController < ApplicationController

  before_action :user_signed_in?
  before_action :authenticate_user!
  require 'faker'

  def index
    if Category.where(user_id: current_user.id).empty?
      Category.create!(title: "Osobní", user_id: current_user.id, color: add_color )
      Category.create!(title: "Škola", user_id: current_user.id, color: add_color)
      Category.create!(title: "Práce", user_id: current_user.id, color: add_color)
    end

    if Tag.where(user_id: current_user.id).empty?
      Tag.create!(title: "UCL", user_id: current_user.id, color: add_color)
      Tag.create!(title: "JSE", user_id: current_user.id, color: add_color)
      Tag.create!(title: "WEB", user_id: current_user.id, color: add_color)
      Tag.create!(title: "3DT", user_id: current_user.id, color: add_color)
      Tag.create!(title: "PR1", user_id: current_user.id, color: add_color)
      Tag.create!(title: "PES", user_id: current_user.id, color: add_color)
      Tag.create!(title: "Nákupy", user_id: current_user.id, color: add_color)
      Tag.create!(title: "Wishlist", user_id: current_user.id, color: add_color)
    end

    if Task.where(user_id: current_user.id).empty?
      Task.create!(title: "Toto je jednoduchý úkol", category_id: nil, is_done: false, deadline_at: add_date , user_id: current_user.id)
      Task.create!(title: "Toto je už dokončený úkol", category_id: nil, is_done: true,deadline_at: add_date , user_id: current_user.id)
      Task.create!(title: "Nakoupit na večeři", category_id: cat_exp(1)[0],deadline_at: add_date , user_id: current_user.id, tags: tag_exp(1) )
      Task.create!(title: "Udělat semestrální práci z předmětu WEB", category_id: cat_exp(2)[0],deadline_at: add_date , is_done: true, user_id: current_user.id, tags:tag_exp(2))
    end

  end

  private

  def add_date
    DateTime.now + (rand * 31)
  end

  def add_color
    Faker::Color.rgb_color.join(", ")
  end

  def cat_exp(num)
    if num == 1
      tempcat = Category.where(user_id: current_user.id,title: "Osobní").ids
    else
      tempcat = Category.where(user_id: current_user.id,title: "Škola").ids
    end
  end

  def tag_exp(num)
    if num == 1
      @temptag = Tag.where(user_id: current_user.id, title: "Nákupy")
    else
      @temptag = Tag.where(title: "UCL").or(Tag.where(title:"WEB")).where(user_id: current_user.id)
    end

  end


end
