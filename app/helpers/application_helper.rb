module ApplicationHelper

  def render_diff(diff)
    diff.words.map do |word|
      content_tag :span, word.content, word_span_attrs(word)
    end.join.html_safe
  end

  def word_span_attrs(word)
    css_class = ''

    css_class << 'line-break ' if word.content == "\n"
    css_class << 'paragraph-break ' if word.content == "\n\n"
    css_class << 'added ' if word.added?
    css_class << 'deleted ' if word.deleted?

    {class: css_class} unless css_class.blank?
  end

end
