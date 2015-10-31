module UsersHelper
  def has_authored_posts?(user)
    user.posts.count > 0 ? true : false
  end

  def has_authored_comments?(user)
    user.comments.count > 0 ? true : false
  end

  def has_favorites?(user)
    user.favorites.count > 0 ? true : false
  end
end
