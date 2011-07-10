class Membership < ActiveRecord::Base
	has_many :renewals, :dependent => :destroy
	has_many :members, :dependent => :destroy
	has_many :membership_volunteer_category_joins
	has_many :volunteer_categories, :through => :membership_volunteer_category_joins
	
	def self.per_page
		50
	end
	
	USStates = ["Washington", "Alabama", "Alaska", "American Samoa", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Guam", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Northern Marianas Islands", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Virgin Islands", "West Virginia", "Wisconsin", "Wyoming"]
	
	
	accepts_nested_attributes_for :members, :renewals
	
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
	
	def last_names
		members.map {|m| m.last_name}.uniq.join("/")
	end
	
	def first_names
		members.map {|m| m.first_name}.uniq.join("/")
	end
	
	def last_renewal
		renewals.order(:date.asc).last
	end
	
	def last_renewal_date
		last_renewal ? last_renewal.date.to_s : "NA"
	end

end
