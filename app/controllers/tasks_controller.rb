class TasksController < ApplicationController

  before_action :user_signed_in?
  before_action :authenticate_user!

  def index
  end

  def new
    @task = Task.new
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

  private
  def tasks_params
    params.require(:task).permit( :deadline_at,:title,:note,:is_done, :current_user)
  end
end
