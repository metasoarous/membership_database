class Membership < ActiveRecord::Base
	has_many :renewals
	has_many :members
	has_many :membership_volunteer_category_joins
	has_many :volunteer_categories, :through => :membership_volunteer_category_joins
	
	accepts_nested_attributes_for :members
	
	# Note - affix_percents is defined in lib/string_extensions.rb. It 
	# lets the search queries be inexact.
	scope :member_field_like, lambda { | field, query |
		joins(:members).where(:members => {field.matches => query.affix_percents })
	}
	
	scope :field_like, lambda {|field, query| 
		where field.matches => query.affix_percents
	}
	
	scope :address_like, lambda {|query| 
		where({:home_address.matches => query.affix_percents} | {:mailing_address.matches => query.affix_percents})
	}
	
	scope :member_or_membership_field_like, lambda {|field, query|
		joins(:members).where({:members => {field.matches => query.affix_percents}} | {field.matches => query.affix_percents })
	}
	
	def full_home_address
		home_address + "\n" + "#{city}, #{state} #{zip}"
	end
	

end
