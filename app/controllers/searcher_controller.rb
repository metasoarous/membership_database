class SearcherController < ApplicationController

	def create
		@searcher = Searcher.new(params[:searcher])

		respond_to do |format|
			if @searcher.valid?
				format.html { render :show}
			end
		end
	end
end