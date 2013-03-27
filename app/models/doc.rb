class Doc < ActiveRecord::Base

  has_many :versions
  has_one  :latest_version, class_name: 'Version', order: 'number desc'

  before_create :set_permalink

  def to_param
    permalink
  end

  def content
    if version = latest_version || versions.last
      version.content
    end
  end

  def content=(initial_content)
    versions.build(content: initial_content)
  end

  private

  def set_permalink
    self.permalink = SecureRandom.hex(6)
  end
end
