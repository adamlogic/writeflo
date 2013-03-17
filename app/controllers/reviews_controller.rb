class ReviewsController < ApplicationController

  assume(:doc) { Doc.find(params[:doc_id]) }

  def new
  end

end
