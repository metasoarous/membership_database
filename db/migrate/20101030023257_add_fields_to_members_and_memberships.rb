class AddFieldsToMembersAndMemberships < ActiveRecord::Migration
	def self.up
		add_column :memberships, :accepts_newsletters, :boolean
	end

	def self.down
		remove_column :memberships, :accepts_newsletters
	end
end
