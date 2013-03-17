class DocsController < ApplicationController

  assume(:doc) { params[:id] ? Doc.find(params[:id]) : Doc.new(params[:doc]) }

  def new
  end

  def create
    doc.save!
    redirect_to [:share, doc]
  end

end
