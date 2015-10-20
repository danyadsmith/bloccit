class FavoriteMailer < ApplicationMailer
  default from: "danyadsmith@gmail.com"

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@bloccit.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@bloccit.example>"
    headers["References"] = "<post/#{post.id}@bloccit.example>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(user, post)
    headers["Message-ID"] = "<post/#{post.id}@bloccit.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@bloccit.example>"
    headers["References"] = "<post/#{post.id}@bloccit.example>"

    @user = user
    @post = post

    mail(to: user.email, subject: "Your post #{post.title} has been automatically favorited", body: "You will receive e-mail notifications for every comment added to your post. If you do not wish to receive these notifications, please visit the post and unfavorite.")    
  end
end
