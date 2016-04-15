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
      flash[:error]= @newsletter.errors.full_messages.to_sentence
      redirect_to new_user_newsletter_path
    end
  end

  def show
    finder
    @newsletter.trades.build(user_id: @user.id, newsletter_id: @newsletter.id)
    flash[:error]= @newsletter.errors.full_messages.to_sentence
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
    if @newsletter.update(newsletter_params)
      redirect_to user_newsletters_path(@user, @newsletter)
    else
      flash[:error]= @newsletter.errors.full_messages.to_sentence
      redirect_to edit_user_newsletter_path
    end
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
    if user_signed_in?
      current_user.id == @newsletter.user_id
    else
      false
    end
  end
end
