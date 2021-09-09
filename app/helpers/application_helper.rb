module ApplicationHelper

  def longtext(text)
    safe_join(text.to_s.split("\n"), tag(:br))
  end

  # def store_image(store)
  #   recent_microposts = Micropost.where(store_id: store.id).order(created_at: "DESC").limit(1)
  #   if recent_microposts.size == 0
  #     return "/no_image.png"
  #   else
  #     @recent_micropost = recent_microposts[0]
  #     return @recent_micropost.micropost_image
  #   end
  # end

end
