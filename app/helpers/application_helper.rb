module ApplicationHelper
  def highlight_keyword(text, keyword)
    return text if keyword.blank?

    text.gsub(/(#{Regexp.escape(keyword)})/i, '<span class="highlight">\1</span>').html_safe
  end
end