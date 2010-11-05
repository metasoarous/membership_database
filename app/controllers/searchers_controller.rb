require "active_support/core_ext/hash/keys.rb"

class SearchersController < ApplicationController

	def create
		
		@searcher = Searcher.new(params[:searcher])
		

		respond_to do |format|
			if @searcher.valid?
				@results = @searcher.results
				format.html { render :show}
			end
		end
	end
end