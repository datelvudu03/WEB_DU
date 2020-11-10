class MainPagesController < ApplicationController
  before_action :user_signed_in?
  before_action :authenticate_user!
  def index
    if Category.where(user_id: current_user.id).empty?

      Category.create!(title: "Osobní", user_id: current_user.id)
      Category.create!(title: "Škola", user_id: current_user.id)
      Category.create!(title: "Práce", user_id: current_user.id)
    end

    if Tag.where(user_id: current_user.id).empty?
      Tag.create!(title: "UCL", user_id: current_user.id)
      Tag.create!(title: "JSE", user_id: current_user.id)
      Tag.create!(title: "WEB", user_id: current_user.id)
      Tag.create!(title: "3DT", user_id: current_user.id)
      Tag.create!(title: "PR1", user_id: current_user.id)
      Tag.create!(title: "PES", user_id: current_user.id)
      Tag.create!(title: "Nákupy", user_id: current_user.id)
      Tag.create!(title: "Wishlist", user_id: current_user.id)
    end

    if Task.where(user_id: current_user.id).empty?
      Task.create!(title: "Toto je jednoduchý úkol", category_id: nil, is_done: false, user_id: current_user.id)
      Task.create!(title: "Toto je už dokončený úkol", category_id: nil, is_done: true, user_id: current_user.id)
      Task.create!(title: "Nakoupit na večeři", category_id: Category.where(user_id: current_user.id,title: "Osobní").ids, user_id: current_user.id, tags: tag_exp(1) )
      Task.create!(title: "Udělat semestrální práci z předmětu WEB", category_id: Category.where(user_id: current_user.id,title: "Škola").ids, is_done: true, user_id: current_user.id, tags:tag_exp(2))
    end

    redirect_to tasks_path
  end

  private
  def tag_exp (num)
    if num == 1
      @temptag = Tag.where(user_id: current_user.id, title: "Nákupy")
    else
      @temptag = Tag.where(title: "UCL").or(Tag.where(title:"WEB")).where(user_id: current_user.id)
    end

  end


end
