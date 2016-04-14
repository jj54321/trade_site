class NewslettersController < ApplicationController

  def index
    finder
   @newsletters = Newsletter.all
  end

  def new
    finder
    @newsletter = Newsletter.new
    @newsletter.trades.build(user_id: current_user.id)
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    @newsletter.user_id = current_user.id
    if @newsletter.save
      redirect_to user_newsletter_path(current_user, @newsletter)
    else
      render '/new'
    end
  end

  def show
    finder
  end

  def destroy
    finder
    @newsletter.delete
    redirect_to user_newsletters_path(current_user)
  end

  def edit
    finder
  end

  def update
    finder
    @newsletter.update(newsletter_params)
    redirect_to user_newsletters_path(@user, @newsletter)
  end

  private

  def finder
    @user = User.find_by_id(params[:user_id])
    @newsletter = Newsletter.find_by_id(params[:id])
  end

  def newsletter_params
    params.require(:newsletter).permit(:title, :content, :trades_attributes => [:instrument,:entry, :stop, :take_profit, :direction,:user_id])
  end
end
