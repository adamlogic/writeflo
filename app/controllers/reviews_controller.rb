class ReviewsController < ApplicationController

  assume(:version) { params[:version_id] ? Version.find_by_permalink!(params[:version_id]) : Version.landing_page }
  assume(:review) { params[:id] ? version.reviews.find(params[:id]) : version.new_review(review_params) }
  assume(:doc) { version.doc }

  def new
    render :show
  end

  def create
    review.save! unless review.content_matches_doc?
    thanks_or_preview
  end

  def show
  end

  def update
    review.update_attributes!(review_params)
    thanks_or_preview
  end

  def preview
  end

  def thanks
  end

  private

  def review_params
    params.require(:review).permit(:content) if params[:review]
  end

  def thanks_or_preview
    if params[:preview]
      if review.persisted?
        redirect_to [:preview, version, review]
      else
        redirect_to [:new, version, :review]
      end
    else
      redirect_to thanks_path
    end
  end

end
