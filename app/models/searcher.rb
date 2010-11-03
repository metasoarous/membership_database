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
	
	FIELDS = {"First Name" => :first_name, "Last Name" => :last_name }
	MEMBER_ONLY_FIELDS = [:first_name, :last_name]
	MEMBERSHIP_ONLY_FIELDS = [:address]
	MEMBERSHIP_OR_MEMBER_FIELDS =	[:email, :phone]

	
	def initialize(attributes = {})
		@field, @query = attributes[:field], attributes[:query]
	end
	
	# This is where the magic is - it decides which of our magic scopes to call
	def results
		case @field
		when :first_name, :last_name
			scope = ("members_" + @field.to_s + "_like").to_sym
			return Membership.member_field_like(@field, @query)
		when :email, :phone
			
		when :address
			return Membership.address_like(@query)
		end
	end
	
end