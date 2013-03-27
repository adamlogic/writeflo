class Doc < ActiveRecord::Base

  has_many :versions
  has_one  :latest_version, class_name: 'Version', order: 'number desc'

  before_create :set_permalink

  delegate :content, to: :latest_version, allow_nil: true

  def to_param
    permalink
  end

  def content=(initial_content)
    versions.new(content: initial_content)
  end

  private

  def set_permalink
    self.permalink = SecureRandom.hex(6)
  end
end
