# encoding: utf-8
class Member < ActiveRecord::Base
	belongs_to :membership
	has_many :member_volunteer_category_joins
	has_many :volunteer_categories, :through => :member_volunteer_category_joins
end
