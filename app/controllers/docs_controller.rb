class DocsController < ApplicationController

  assume(:doc) { params[:id] ? Doc.find_by_permalink!(params[:id]) : Doc.new(doc_params) }

  def new
    render :show
  end

  def create
    doc.save!
    redirect_to [:share, doc]
  end

  def show
  end

  def update
    doc.update_attributes!(doc_params)
    redirect_to [:share, doc]
  end

  private

  def doc_params
    if params[:doc]
      params.require(:doc).permit(:content)
    else
      { content: 'Start writing.' }
    end
  end

end
