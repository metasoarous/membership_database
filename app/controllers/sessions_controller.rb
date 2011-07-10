class SessionsController < ApplicationController
  def toggle_membership_view
  	case session[:membership_view]
  	when :cards
  		session[:membership_view] = :table
  	when :table
  		session[:membership_view] = :cards
  	end
  	redirect_to root_path
  end
end
