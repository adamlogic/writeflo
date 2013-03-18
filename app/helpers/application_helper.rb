module ApplicationHelper
  def content_to_html(text)
    text.gsub!(/\r\n?/, "\n") # normalize line breaks

    html = text.split(/\n\n+/).map do |paragraph|
      paragraph.scan(/\w+|<[^>]*>|./).map do |chunk|
        "<span>#{chunk}</span>"
      end.join
    end.map do |paragraph|
      "<p>#{paragraph}</p>"
    end.join

    html.html_safe

    #TODO: handle single line breaks
    #TODO: encode html in the content
    # html.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
  end
end
