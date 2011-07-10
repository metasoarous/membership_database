require "active_support/core_ext/hash/keys.rb"

class SearchersController < ApplicationController

	def create
		
		@searcher = Searcher.new(params[:searcher])

		respond_to do |format|
			if @searcher.valid?
				@memberships = @searcher.results.uniq
				format.html { render :show}
			else
				format.html { redirect_to "/", :notice => "Make sure you select a field for the searcher."}
			end
		end
	end
end
