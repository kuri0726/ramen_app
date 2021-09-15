module SearchHelper

  def avg_score(store)
    store_microposts = store.store_feed
    if store_microposts.empty?
      store_microposts = false
    else
      @avg_score = store_microposts.average(:score).round(1)
      return @avg_score
    end
  end

  def photos_counter(store)
    photo_counter = []
    microposts = store.store_feed
    microposts.each do |micropost|
      if !micropost.micropost_image.empty? && micropost.micropost_image != "no_image.png"
        photo_counter.push(micropost.micropost_image)
      end
    end
    return photo_counter.count
  end

end
