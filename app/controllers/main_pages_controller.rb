class MainPagesController < ApplicationController
  before_action :user_signed_in?
  before_action :authenticate_user!
  def index
    redirect_to tasks_path
  end


end
