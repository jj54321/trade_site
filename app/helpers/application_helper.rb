module ApplicationHelper

  def date_created(model)
    model.created_at.strftime("%d %b. %Y")
  end

  def time_created(model)
    model.created_at.strftime("%H:%M")
  end

  def authenticate?
    if user_signed_in?
      if owner?
        return true
      end
    end
  end

  def owner?
    current_user.id == @newsletter.user_id
  end
end
