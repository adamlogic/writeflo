class ReviewsController < ApplicationController

  assume(:doc) { Doc.find_by_permalink!(params[:doc_id]) }
  assume(:review) { params[:id] ? doc.reviews.find(params[:id]) : doc.new_review(review_params) }

  def new
  end

  def create
    review.save!
    redirect_to [doc, review]
  end

  def show
    render :new
  end

  private

  def review_params
    params.require(:review).permit(:content) if params[:review]
  end

end
