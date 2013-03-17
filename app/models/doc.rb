class Doc < ActiveRecord::Base

  before_create :set_permalink

  def to_param
    permalink
  end

  private

  def set_permalink
    self.permalink = SecureRandom.hex(6)
  end
end
