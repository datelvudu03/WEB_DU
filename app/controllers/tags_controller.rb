class TagsController < ApplicationController

  def index
    @tags = Tag.where(user_id: current_user.id)
  end

  def new
    @tag = Tag.new
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.user_id = current_user.id
    if @tag.save
      redirect_to tags_path
    else
      render 'new'
    end
  end

  def update
    @tag = Tag.find(params[:id])

    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render 'edit'
    end
  end

  def destroy
    @tag = Tag.find(params[:id]).destroy
    redirect_to tags_path
  end

  private
  def tag_params
    params.require(:tag).permit(:title,:color)
  end
end
