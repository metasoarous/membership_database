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
	
	
	
	def initialize(attributes)
		@field, @query = attributes[:fields], attributes[:query]
	end
	
	def results
		if MEMBERS_ONLY_FIELDS.include? @field
			
		end
	end
	
end