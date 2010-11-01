class ApplicationController < ActionController::Base
	protect_from_forgery
	
	before_filter :create_new_searcher
	
	private
	
		def create_new_searcher
			@searcher = Searcher.new
		end
end
