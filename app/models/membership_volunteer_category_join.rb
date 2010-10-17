class MembershipVolunteerCategoryJoin < ActiveRecord::Base
	belongs_to :membership
	belongs_to :volunteer_category
end
