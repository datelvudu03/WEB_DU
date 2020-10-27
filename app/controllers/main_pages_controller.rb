class MainPagesController < ApplicationController
  before_action :user_signed_in?
  before_action :authenticate_user!
  def index
  end


end
