class Doc < ActiveRecord::Base
  WORD_REGEX = /\w+|<[^>]*>|\n{1,2}|./

  before_create :set_permalink

  def to_param
    permalink
  end

  def words
    text = content.gsub(/\r\n?/, "\n") # normalize line breaks
    text.scan WORD_REGEX
  end

  private

  def set_permalink
    self.permalink = SecureRandom.hex(6)
  end
end
