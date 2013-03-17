class Review < ActiveRecord::Base
  belongs_to :doc
  # attr_accessible :title, :body
end
