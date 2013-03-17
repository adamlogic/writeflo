class DocsController < ApplicationController

  assume(:doc) { params[:id] ? Doc.find(params[:id]) : Doc.new(doc_params) }

  def new
  end

  def create
    doc.save!
    redirect_to [:share, doc]
  end

  def show
  end

  private

  def doc_params
    params.require(:doc).permit(:content) if params[:doc]
  end

end
