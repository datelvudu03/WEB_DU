class TasksController < ApplicationController

  before_action :user_signed_in?
  before_action :authenticate_user!

  def index
    @tasks = Task.where(user_id: current_user.id).page(params[:page])
    #@user_tags = TagAssociation.joins("INNER JOIN tasks ON tasks.id == tag_associations.task_id where tasks.user_id = #{current_user.id}")
    @user_task_tag = User.find(current_user.id).tags

    @search = params['search']
    if @search.present?
      @title = @search['title']
      @tasks = Task.where('title LIKE ?', "%#{@title}%").where(user_id: current_user.id).page(params[:page])
    end


    @search_cat = params[:task]

    if @search_cat.present?
      @search_cat[:category_id] = nil if @search_cat[:category_id].blank?
      @tasks = Task.where(user_id: current_user.id, category_id: @search_cat[:category_id]).page(params[:page])
    end

  end

  def edit
    @task = Task.find(params[:id])
    @all_tags = Tag.where(user_id: current_user.id)
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(tasks_params)
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  def new
    @task = Task.new
    @tag_associations = @task.tag_associations.build
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(tasks_params)
    @task.user_id = current_user.id
    @task.save
    redirect_to @task
  end

  def destroy
    @task = Task.find(params[:id]).destroy
    redirect_to tasks_index_path
  end

  helper_method :add_color_cat, :add_cat, :add_color_tag

  private

  def add_cat(cat_id)
    if cat_id.nil?
      'No Category'
    else
      Category.find(cat_id).title
    end
  end

  def add_color_cat(cat_id)
    if cat_id.nil?
       '255, 0, 0'
    else
      Category.find(cat_id).color
    end
  end

  def add_color_tag(tag_id)
    if tag_id.nil?
      '255, 0, 0'
    else
      Tag.find(tag_id).color
    end
  end

  def tasks_params
    params.require(:task).permit(:deadline_at, :title, :search, :tags, :note, :is_done, :category_id, :user_id, {tag_ids: []})
  end

end
