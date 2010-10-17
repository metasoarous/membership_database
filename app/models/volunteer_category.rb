class VolunteerCategory < ActiveRecord::Base
	has_many :membership_volunteer_category_joins
	has_many :member_volunteer_category_joins
	has_many :memberships, :through => :membership_volunteer_category_joins
	has_many :members, :through => :member_volunteer_category_joins
end
