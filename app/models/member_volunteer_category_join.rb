class MemberVolunteerCategoryJoin < ActiveRecord::Base
	belongs_to :member
	belongs_to :volunteer_category
end
