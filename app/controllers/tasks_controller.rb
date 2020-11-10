class TasksController < ApplicationController

  before_action :user_signed_in?
  before_action :authenticate_user!

  def index
    @tasks = Task.where(user_id: current_user.id)
    #@user_tags = TagAssociation.joins("INNER JOIN tasks ON tasks.id == tag_associations.task_id where tasks.user_id = #{current_user.id}")
    @user_task_tag = User.find(current_user.id).tags
    @user_all_tags = User.find(current_user.id).tags
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
    @task= Task.find(params[:id])
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

  private
  def tasks_params
    params.require(:task).permit( :deadline_at,:title,:note,:is_done, :category_id, :user_id, {:tag_ids => []} )
  end

end
