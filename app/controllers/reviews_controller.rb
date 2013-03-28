class ReviewsController < ApplicationController

  assume(:version) { Version.find_by_permalink!(params[:version_id]) }
  assume(:review) { params[:id] ? version.reviews.find(params[:id]) : version.new_review(review_params) }
  assume(:doc) { version.doc }
  assume(:review_diff) { ContentDiff.new(review.content, version.content) }

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
      [:preview, version, review]
    else
      [version, review]
    end
  end

end
