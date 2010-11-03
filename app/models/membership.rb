class Membership < ActiveRecord::Base
	has_many :renewals
	has_many :members
	has_many :membership_volunteer_category_joins
	has_many :volunteer_categories, :through => :membership_volunteer_category_joins
	
	accepts_nested_attributes_for :members
	
	scope :find_by_member_field_like, lambda { | field, query |
		joins(:members).where(:members => {field.matches => "%" + query + "%" })
	}
	
	def full_home_address
		home_address + "\n" + "#{city}, #{state} #{zip}"
	end
	

end
