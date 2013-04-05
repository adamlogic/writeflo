class Review < ActiveRecord::Base

  belongs_to :version

  scope :ordered, order(:created_at)

  def self.at_position(position)
    offset = position.to_i - 1

    if offset >= 0
      ordered.offset(offset).first
    else
      nil
    end
  end

  def content_matches_doc?
    puts '***'
    puts content
    puts '---'
    puts version.content
    puts '***'
    content == version.content
  end

end
