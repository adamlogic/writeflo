module ApplicationHelper
  def content_to_html(text)
    text.gsub!(/\r\n?/, "\n") # normalize line breaks

    html = text.scan(/\w+|<[^>]*>|\n{1,2}|./).map do |word|
      content_tag :span, word, word_span_attrs(word)
    end.join

    html.html_safe
  end

  def word_span_attrs(word)
    if word == "\n"
      {class: 'line-break'}
    elsif word == "\n\n"
      {class: 'paragraph-break'}
    end
  end
end
