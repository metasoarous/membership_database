# This class depends on the searchlogic gem - if you want to extend or clean
# up the search functionality here, definitely take a look at the readme on
# github - http://github.com/binarylogic/searchlogic.
#
# Update - as it turns out, the main searchlogic library does not yet support
# Rails 3, so this application is now using rd_searchlogic, a fork that has
# baked in support. Everything should work the same though - keep posted and
# try to switch to the main project one support is offered, as it is likely
# to be better meaintained once things are working.

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
	
	def results
		#debugger
		case @field
		when :first_name, :last_name
			scope = ("members_" + @field.to_s + "_like").to_sym
			return Membership.searchlogic( scope => @query)
		when :email, :phone
			
		when :address
			
		end
	end
	
end