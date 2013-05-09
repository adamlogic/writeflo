class Version < ActiveRecord::Base
  LANDING_PAGE_PERMALINK = 'landing-page'

  belongs_to :doc
  has_many :reviews, dependent: :destroy

  before_create :set_version_number
  before_create :set_permalink

  def self.landing_page
    find_by_permalink! LANDING_PAGE_PERMALINK
  end

  def to_param
    permalink
  end

  def new_review(params)
    params ||= {}
    params.reverse_merge! content: content
    reviews.new params
  end

  def landing_page?
    permalink == LANDING_PAGE_PERMALINK
  end

  private

  def set_version_number
    self.number = doc.versions.count + 1
  end

  def set_permalink
    self.permalink = SecureRandom.hex(6)
  end

end
