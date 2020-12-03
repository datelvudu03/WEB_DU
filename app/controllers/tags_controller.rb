class TagsController < ApplicationController
  load_and_authorize_resource
  before_action :user_signed_in?
  before_action :authenticate_user!
  def index
    @tags = Tag.order(:title).where(user_id: current_user.id)
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
    temp = covert_hex_rgb(@tag.color)
    @tag.color.clear << temp

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
  helper_method :count_tasks, :tag_task

  private

  def covert_hex_rgb(hex)
    "#{hex[1,6]}".scan(/../).map {|color| color.to_i(16)}.join(", ")
  end

  def tag_task(id)
    Tag.find(id).tasks
  end

  def count_tasks(id)
    Tag.find(id).tasks.count
  end

  def tag_params
    params.require(:tag).permit(:title,:color)
  end
end
