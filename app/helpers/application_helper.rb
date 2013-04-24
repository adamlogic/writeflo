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

  def link_to_review(link_text, opts = {})
    position  = opts.delete(:position)
    css_class = opts.delete(:class)

    if (1..version.reviews.count).include?(position)
      link_to link_text, doc_path(doc, position: position), class: css_class
    else
      css_class << ' disabled'
      content_tag :span, link_text, class: css_class
    end
  end

end
