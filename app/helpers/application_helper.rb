module ApplicationHelper
  def content_to_html(text)
    text.gsub!(/\r\n?/, "\n") # normalize line breaks

    html = text.scan(/\w+|<[^>]*>|\n+|./).map do |word|
      content_tag :span, word, word_span_attrs(word)
    end.join

    html.html_safe

    #TODO: handle single line breaks
    #TODO: encode html in the content
    # html.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
  end

  def word_span_attrs(word)
    if word == "\n\n"
      {class: 'paragraph-break'}
    end
  end
end
