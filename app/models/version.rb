class Version < ActiveRecord::Base

  belongs_to :doc
  has_many :reviews

  before_create :set_version_number
  before_create :set_permalink

  def to_param
    permalink
  end

  def new_review(params)
    params ||= {}
    params.reverse_merge! content: content
    reviews.new params
  end

  private

  def set_version_number
    self.number = doc.versions.count + 1
  end

  def set_permalink
    self.permalink = SecureRandom.hex(6)
  end

end
