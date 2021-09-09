module ApplicationHelper

  def longtext(text)
    safe_join(text.to_s.split("\n"), tag(:br))
  end

end
