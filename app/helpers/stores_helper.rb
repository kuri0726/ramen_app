module StoresHelper

  def select_week(i)
    if i.nil? || i == ""
      @week = "未選択"
    else
      weeks = ["平日", "土日"]
      @week = weeks[i.to_i]
    end
  end

  def select_from_to(time)
    if time.nil? || time == ""
      @time = "未選択"
    else
      @time = time.to_time.strftime('%H時台').to_s
    end
  end

end
