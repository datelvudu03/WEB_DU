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
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit( :title,:color)
  end
end
