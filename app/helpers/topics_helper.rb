module TopicsHelper
  def user_is_authorized_to_update_topics?
    current_user && (current_user.moderator? || current_user.admin?)
  end

  def user_is_authorized_for_topics?
    current_user && current_user.admin? 
  end
end
