class NewslettersController < ApplicationController

  def index
   @user = User.find_by_id(params[:user_id])
   @newsletters = Newsletter.all
  end

  def new
    @user = User.find_by_id(params[:user_id])
    @newsletter = Newsletter.new
  end
end
