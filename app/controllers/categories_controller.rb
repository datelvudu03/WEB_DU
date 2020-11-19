class CategoriesController < ApplicationController

  def index
    @categories = Category.where(user_id: current_user.id)
  end
  def new
    @category = Category.new
  end
  def show
    @category= Category.find(params[:id])
  end
  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    temp = covert_hex_rgb(@category.color)
    @category.color.clear << temp
    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id]).destroy
    @task = Task.find_by(category_id: params[:id])
    @task.update(category_id: nil)
    redirect_to categories_path
  end

  helper_method :count_tasks, :category_task

  private

  def covert_hex_rgb(hex)
    "#{hex[1,6]}".scan(/../).map {|color| color.to_i(16)}.join(", ")
  end

  def category_task(id)
    Category.find(id).tasks
  end

  def count_tasks(id)
    Category.find(id).tasks.count
  end

  def category_params
    params.require(:category).permit( :title,:color)
  end
end
