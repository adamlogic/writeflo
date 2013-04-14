module ApplicationHelper

  def render_diff(old, new)
    Differ.tokens(old, new).map do |token|
      content_tag :span, token.content, word_span_attrs(token)
    end.join.html_safe
  end

  def word_span_attrs(token)
    css_class = ''

    css_class << 'line-break ' if token.content == "\n"
    css_class << 'paragraph-break ' if token.content == "\n\n"
    css_class << 'added ' if token.added?
    css_class << 'deleted ' if token.deleted?

    {class: css_class} unless css_class.blank?
  end

end
