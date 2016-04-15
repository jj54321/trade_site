module NewslettersHelper

  def is_author?
    current_user.id == @newsletter.user_id
  end


end
