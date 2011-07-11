# This class depends heavily on the magic of the meta_where gem. Wanted
# to use searchlogic, as it seemed like the most natural tool for the job,
# but as it turns out, it does not yet work with Rails 3. So for now (and
# possibly ever), this will do.

class Searcher
	include ActiveModel::AttributeMethods
	include ActiveModel::Validations
	include ActiveModel::Conversion
	
	def persisted?
		false
	end
	
	# Id is just to fool simple_form_for into working for instance of this class.
	define_attribute_methods [:field, :query, :id]
	
	attr_accessor :field, :query, :id
	
	validates_presence_of :field
	validates_presence_of :query
	
	FIELDS = [["First Name", :first_name], ["Last Name", :last_name], ["Address", :address], ["Email", :email], ["Phone", :phone], ["Membership Number", :number], ["Renewal Date (start_date - end_date)", :renewal_date], ["Complex", :complex] ]
	
	def initialize(attributes = {})
		if attributes[:field].nil? or attributes[:field] == "" 
			@field = nil
		else
			@field = attributes[:field] ? attributes[:field].to_sym : attributes[:field]
			@query = attributes[:query]
			@id = 1
		end
	end
	
	# This is where the magic is - it decides which of our magic scopes to call
	# The rest of the magic is in the scopes defined in the Membership class
	def results
		case @field
		when nil
			return Membership.all
		# Member only fields
		when :first_name, :last_name
			scope = ("members_" + @field.to_s + "_like").to_sym
			results = Membership.member_field_like(@field, @query)
		# Member or Membership fields
		when :email, :phone
			results = Membership.member_or_membership_field_like(@field, @query)
		# Membership only fields
		when :address
			results = Membership.address_like(@query)
		when :number
			results = Membership.where(:number => @query)
		when :renewal_date
			#debugger
			results = Membership.renewal_date_between(@query)
		when :complex
			results = eval("Membership." + @query)
		end
		return results.order(:number.asc)
	end
	
end
