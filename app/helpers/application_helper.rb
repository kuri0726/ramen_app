module ApplicationHelper

  def full_title(page_title = '')
    base_title = "らぁ麺インフォメーション"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def longtext(text)
    safe_join(text.to_s.split("\n"), tag(:br))
  end

end
