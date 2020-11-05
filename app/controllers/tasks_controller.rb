class TasksController < ApplicationController

  before_action :user_signed_in?
  before_action :authenticate_user!

  def index
    @tasks = Task.where(user_id: current_user.id)
    @user_tags = TagAssociation.joins("INNER JOIN tasks ON tasks.id == tag_associations.task_id where tasks.user_id = #{current_user.id}")
    @user_all_tags = Tag.where(user_id: current_user.id)
  end

  def edit
    @task = Task.find(params[:id])
    @all_tags = Tag.where(user_id: current_user.id)
  end

  def update
    @task = Task.find(params[:id])
    @tag_association = TagAssociation.where(task_id: params[:id]).destroy_all

    params[:tags][:id].each do |tag|
      if !tag.empty?
        @task.tag_associations.build(tag_id: tag)
      end
    end


    if @task.update(tasks_params)
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  def new
    @task = Task.new
    @user_catergories = User.find(current_user.id).categories
    @all_tags = User.find(current_user.id).tags
    @task_tags_association = @task.tag_associations.build
  end

  def show
    @task= Task.find(params[:id])
  end

  def create

    @task = Task.new(tasks_params)
    @task.user_id = current_user.id

    params[:tags][:id].each do |tag|
      if !tag.empty?
        @task.tag_associations.build(tag_id: tag)
      end
    end

    @task.save
    redirect_to @task
  end

  def destroy
    @tag_association = TagAssociation.where('task_id = ?', params[:id]).destroy_all
    @task = Task.find(params[:id]).destroy

    redirect_to tasks_index_path
  end



  private
  def tasks_params
    params.require(:task).permit( :deadline_at,:title,:note,:is_done, :category_id, :tag_id, :user_id)
  end



end
