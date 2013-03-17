class ReviewsController < ApplicationController

  assume(:doc) { Doc.find_by_permalink!(params[:doc_id]) }

  def new
  end

end
