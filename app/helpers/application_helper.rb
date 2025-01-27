module ApplicationHelper
  def highlight_keyword(text, keyword)
    return text if keyword.blank?

    sanitized_text = ERB::Util.html_escape(text)
    sanitized_keyword = Regexp.escape(keyword)
    sanitized_text.gsub(/(#{sanitized_keyword})/i) do
      '<span class="highlight">' + Regexp.last_match(1) + '</span>'
    end.html_safe
  end
  
  def bootstrap_class_for(flash_type)
    case flash_type
    when "notice"
      "alert-success" 
    when "alert"
      "alert-danger" 
    else
      "alert-info" 
    end
  end
end