module ApplicationHelper
  def words_to_html(words)
    words.map do |word|
      content_tag :span, word, word_span_attrs(word)
    end.join.html_safe
  end

  def word_span_attrs(word)
    if word == "\n"
      {class: 'line-break'}
    elsif word == "\n\n"
      {class: 'paragraph-break'}
    end
  end
end
