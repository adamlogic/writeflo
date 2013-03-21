class ReviewsController < ApplicationController

  assume(:doc) { Doc.find_by_permalink!(params[:doc_id]) }
  assume(:review) { params[:id] ? doc.reviews.find(params[:id]) : doc.new_review(review_params) }
  assume(:review_diff) { ContentDiff.new(review.content, doc.content) }

  def new
    render :show
  end

  def create
    review.save!
    redirect_to review_path
  end

  def show
  end

  def update
    review.update_attributes!(review_params)
    redirect_to review_path
  end

  def preview
  end

  private

  def review_params
    params.require(:review).permit(:content) if params[:review]
  end

  def review_path
    if params[:preview]
      [:preview, doc, review]
    else
      [doc, review]
    end
  end

end
