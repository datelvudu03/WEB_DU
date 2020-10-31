class TasksController < ApplicationController

  before_action :user_signed_in?
  before_action :authenticate_user!

  def index
    @tasks = Task.where(user_id: current_user.id)
  end

  def edit
    @task = Task.find(params[:id])
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
    @all_tags = Tag.all
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
        @task.tag_associations.build(:tag_id => tag)
      end
    end
    @task.save
    redirect_to @task
  end

  def destroy
    @tag_association = TagAssociation.where("task_id = ?", params[:id]).destroy_all
    #find(:all, :conditions => ['task_id = ?', params[:id]]).destroy
    @task = Task.find(params[:id]).destroy

    redirect_to tasks_index_path
  end

  private
  def tasks_params
    params.require(:task).permit( :deadline_at,:title,:note,:is_done, :category_id, :tag_id, :user_id)
  end

end
