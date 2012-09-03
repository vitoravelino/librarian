class SearchController < ApplicationController
  def index
    if params[:q] then
      @page = (params[:page] || 1).to_i
      @search = if not params[:q].blank?
        Thesis.search do
          fulltext params[:q] do
            highlight :text
          end
          paginate :page => @page, :per_page => 15
        end
      end
      
      render :search
    end
  end
end
