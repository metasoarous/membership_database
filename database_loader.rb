# This script was written to load data into the database from the text files
# given to me by Daniel Snyder. The fields were a bit of a mess in a lot of
# ways, so I had to build a pretty comprehensive suite of tools for analysis
# to give us a good understanding of the data and a good set of options
# available for loading it into the database.
#
# So far this only works for Ruby 1.8.7 - Ruby 1.9 has features of string
# encoding which make these data files hard to work with without knowing
# what encoding was used on the files. This shouldn't introduce too many
# problems once hte data is loader up, but if these text archives need to
# be analyzed later,this should be kept in mind - use 1.8.7.



# Defining some helpful extensions of the array class here.
class Array
  def to_hash_keys(&block)
    Hash[*self.collect { |v|
      [v, block.call(v)]
    }.flatten]
  end
  def to_hash_values(&block)
    Hash[*self.collect { |v|
      [block.call(v), v]
    }.flatten]
  end
end



# This class contains all of the magic. On instantiation we load a file of data
# and the code here processes it and maps the rows to instances of a class
# called MembershipData defined below. We also have a suite of analytical
# and investigative methods defined here which allow us to ask questions
# about each of the data sets.
class DatabaseLoader

	class << self
		attr_accessor :fields, :membership_fields
	end
	
	@fields = [:first_name, :home_address, :mailing_address, :city, :state, :zip, :phone, :email, :renewal_dates, :members_since, :amounts_paid, :number, :volunteer_skills, :seasons, :best_contact, :last_name, :first_strange_long_number, :missing, :accepts_newsletters, :second_strange_long_number]
	@membership_fields = [:home_address, :mailing_address, :city, :state, :zip, :phone, :email, :number, :volunteer_skills, :best_contact]
	
	attr_reader :number_of_memberships, :memberships
	
	def initialize(filename)
		raw_text = File.read(filename)
		@memberships = raw_text.split("\r").enum_with_index.map {|text_row, index| MembershipData.new(text_row, index) }
		@number_of_memberships = @memberships.size
	end
	
	def load_memberships
		@memberships.each {|membership| membership.load_to_db}
	end
	
	# Options :strength, :range and :verbose
	def renewal_report(options = {} )
		range = options[:range] || (0...@number_of_memberships)
		options[:verbose] = options.fetch(:verbose, false)
		options[:strength] = options.fetch(:strength, :weak)
		count = 0
		@memberships[range].each do |membership| 
			membership.renewal_report(options) unless options[:summary]
			count += 1 if membership.renewals_funky?(options[:strength])
		end
		puts "\n\n"
		puts "Summary - #{count} errors found "
		puts "\n\n"
		return nil
	end
	
	def column_info(column, range = (0...@number_of_memberships))
		@memberships[range].map {|membership| membership.info(column)}
	end
	
	def read_column_info(column, range = (0...@number_of_memberships))
		column_info(column, range).each_with_index {|info, i| puts "#{i + range.begin} : #{info}"}
		return nil
	end
	
	
	
	
	# As mentioned before, instances of this class contain the information
	# in a given row of the database text files. The methods defines in this
	# class help us deal with individual rows (memberships) both in analysis
	# and data loading.
	class MembershipData
				
		attr_accessor :renewal_data_set, :db_membership, :index
		
		def initialize(text_row, index)
			@data_array = text_row.split("\t")
			@data = DatabaseLoader.fields.to_hash_keys do |key|
				field_index = DatabaseLoader.fields.index(key)
				@data_array[field_index]
			end
			@data[:renewal_dates] = @data[:renewal_dates].split("\035")
			@data[:amounts_paid] = @data[:amounts_paid].split("\035")
			@renewal_data_set = RenewalDataSet.new(self)
			@index = index
		end
		
		# Define quicker accessors for the membership fields as methods
		DatabaseLoader.fields.each do |field|
			define_method field do
				@data[field]
			end
		end
		
		def info(column)
			case column
			when Integer
				@data_array[column]
			when Symbol
				@data[column]
			end
		end
		
		# specify :verbose => false to only spit out info if there are problems, 
		# mainly a useful option so that the entire dataset can only spit out the 
		# reports we are apt to care about 
		def renewal_report(options = {})
			options[:verbose] = options.fetch(:verbose, true)
			options[:strenght] = options.fetch(:strength, :strong)
			# renewals_funky? has to get called for @errors to be defined so put
			# this first- hack, hack
			if renewals_funky?(options[:strength]) or options[:verbose]
				puts "Membership #{@index} : #{first_name}, #{last_name}"
				if @errors.empty?
					puts "  Everything looks good here"
				else
					@errors.each do |error|
						puts "  Error on: #{error.to_s}"
					end
				end
				@renewal_data_set.report
				puts ""
			end
			return nil
		end
		
		# strength here can be set to :strong, :med, :weak or :none
		def renewals_funky?(strength = :med)
			@errors ||= []
			raise "Should have passed in one of :strong, :weak or :none to renewals_funky?" unless [:strong, :weak, :none, :med].include? strength
			return false if strength == :none
			issues = [:dates_and_amounts_sizes_mismatch?]
			issues << :date_lacks_month if strength == :med
			issues += [:dates_contain_question_marks?, 
				:amounts_contain_question_marks?, 
				:dates_contain_blanks?, 
				:amounts_contain_blanks?] if strength == :strong
			issues.each do |method|
				@errors << method if @renewal_data_set.send method
			end
			!@errors.empty?
		end
		
		def load_to_db
			attributes = DatabaseLoader.membership_fields.to_hash_keys {|key| @data[key] }
			attributes.merge(:accepts_newsletters => self.accepts_newsletters != "no" )
			@db_membership = Membership.new(attributes)
			self.renewal_data_set.load_to_db
			@db_membership.save
		end
		
		
		
		
		
		# This class in nested within the MembershipData class and eases the
		# housing of the renewal specifc data, analysis and data loading.
		class RenewalDataSet
			def report
				puts "   Dates:   #{@dates.join(",\t")}"
				puts "   Amounts: #{@amounts.join(",\t")}"
			end
			def initialize(membership)
				@membership = membership
				@dates = membership.renewal_dates
				@amounts = membership.amounts_paid
			end
			def dates_and_amounts_sizes_mismatch?
				@dates.size != @amounts.size
			end
			def dates_contain_question_marks?
				@dates.include? "?"
			end
			def dates_contain_blanks?
				@dates.include? ""
			end
			def date_lacks_month?
				@dates.include? ""
			end
			def amounts_contain_question_marks?
				@amounts.include? "?" 
			end
			def amounts_contain_blanks?
				@amounts.include? ""
			end
			def load_to_db
				create_renewal_datas
				@renewal_datas.each {|rd| rd.load_to_db(@membership.db_membership) }
			end
			def create_renewal_datas
				@renewal_datas ||= []
				@dates.each_with_index do |date, i|
					@renewal_datas << RenewalData.new(date, @amounts[i])
				end
			end
			
			# Still need to build in some better handling here of weird entries
			class RenewalData
				def initialize(date, amount)
					@date, @amount = date, amount
				end
				def load_to_db(db_membership)
					db_membership.renewals.build(:date => @date, :payment_amount => @amount)
				end
			end
		end # of RenewalDataSet class
	
	end # of MembershipData class

end




# Load the file data into two global variables so that we can access them
# through the console.

$current_members = DatabaseLoader.new("current_members.txt")
$past_members = DatabaseLoader.new("past_members.txt")
