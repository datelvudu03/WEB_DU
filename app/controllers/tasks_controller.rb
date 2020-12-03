class TasksController < ApplicationController
  load_and_authorize_resource
  before_action :user_signed_in?
  before_action :authenticate_user!

  def index
    @tasks = Task.where(user_id: current_user.id).order(:deadline_at).page(params[:page])
    @search = params['search']
    if @search.present?
      @title = @search['title']
      @tasks = Task.where('title LIKE ?', "%#{@title}%").or(Task.where('note LIKE ?', "%#{@title}%")).order(:deadline_at).
               where(user_id: current_user.id).page(params[:page])
    end

    @search_cat = params[:task]


    if @search_cat.present?
      counting = 0
      all_tasks = []
      unless @search_cat[:category_id].blank?
        counting += 1
        Task.where(category_id: @search_cat[:category_id]).each do |s_cat|
          all_tasks << s_cat
        end
      end
      unless @search_cat[:tag].blank?
        tags = @search_cat[:tag]
        tags = tags.drop(1)
        tags.each do |tag|
          counting += 1
          task_tag = Tag.find(tag.to_i).tasks
          task_tag.each do |s_tag|
            all_tasks << s_tag
          end
        end
      end
      tasks = all_tasks.tally.select { |k,v| v == counting }
      final_tasks = []
      tasks.each_key {|key| final_tasks << key }
      @tasks = final_tasks.sort_by(&:deadline_at).paginate(page: params[:page], per_page: 30)
      @tasks = [''] if @tasks.nil?
    end
=begin
      if @search_cat[:tag] == ['']
        @tasks = Task.where(user_id: current_user.id, category_id: @search_cat[:category_id]).page(params[:page])
      else
        tasks = []
        s_tags = @search_cat[:tag].drop(1)
        s_category = @search_cat[:category_id]
        @all_tasks = Task.where(user_id: current_user.id)
        @all_tasks.each do |task|
          ok = true
          unless s_category.blank?
            ok = false if task.category_id.to_i != s_category.to_i
          end
          unless s_tags.blank?
            s_tags.each do |tag|
              ok = false if Tag.find(tag).tasks.where(id: task.id).blank?
            end
          end
          if ok == true
            tasks << task
          end
        end
        @tasks = tasks
        end

       end
=end
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
