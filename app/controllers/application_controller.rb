class ApplicationController < ActionController::Base
	protect_from_forgery
	
	before_filter :create_new_searcher
	before_filter :set_default_membership_view
	
	
	private
	
		def create_new_searcher
			@new_searcher = Searcher.new
		end
		
		def set_default_membership_view
			session[:membership_view] ||= :cards
		end
end
