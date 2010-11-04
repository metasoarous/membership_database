# This class depends heavily on the magic of the meta_where gem. Wanted
# to use searchlogic, as it seemed like the most natural tool for the job,
# but as it turns out, it does not yet work with Rails 3. So for now (and
# possibly ever), this will do.

class Searcher
	include ActiveModel::AttributeMethods
	include ActiveModel::Validations
	
	define_attribute_methods [:field, :query]
	
	attr_accessor :field, :query
	
	validates_presence_of :field
	validates_presence_of :query 
	
	FIELDS = {"First Name" => :first_name, "Last Name" => :last_name, "Address" => :address, "Email" => :email, "Phone" => :phone }
	
	def initialize(attributes = {})
		@field = attributes[:field] ? attributes[:field].to_sym : attributes[:field]
		@query = attributes[:query]
	end
	
	# This is where the magic is - it decides which of our magic scopes to call
	# The rest of the magic is in the scopes defined in the Membership class
	def results
		case @field
		when :first_name, :last_name
			scope = ("members_" + @field.to_s + "_like").to_sym
			return Membership.member_field_like(@field, @query)
		when :email, :phone
			return Membership.member_or_membership_field_like(@field, @query)
		when :address
			return Membership.address_like(@query)
		end
	end
	
end