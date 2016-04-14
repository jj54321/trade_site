class NewslettersController < ApplicationController

  def index
    finder
   @newsletters = @user.newsletters.all
  end

  def new
    finder
    @newsletter = Newsletter.new
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
    @newsletter.trades.build(user_id: @user.id, newsletter_id: @newsletter.id)
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
    params.require(:newsletter).permit(:title, :content, :trades_attributes => [:id, :instrument,:entry, :stop, :take_profit, :direction])
  end

  def owner?
    current_user.id == @newsletter.user_id
  end
end
