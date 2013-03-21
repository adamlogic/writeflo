class ContentDiff
  WORD_REGEX = /\w+|<[^>]*>|\n{1,2}|./

  def initialize(new_content, old_content)
    @new_content = split_words(new_content)
    @old_content = split_words(old_content)
  end

  def words
    words = []
    Diff::LCS.traverse_sequences @old_content, @new_content do |event|
      words << Word.new(event)
    end
    words
  end

  class Word
    def initialize(event)
      @event = event
    end

    def content
      deleted? ? @event.old_element : @event.new_element
    end

    def added?
      @event.adding?
    end

    def deleted?
      @event.deleting?
    end
  end

  private

  def split_words(content)
    text = content.gsub(/\r\n?/, "\n") # normalize line breaks
    text.scan WORD_REGEX
  end

end
