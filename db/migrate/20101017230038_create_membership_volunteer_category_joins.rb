class CreateMembershipVolunteerCategoryJoins < ActiveRecord::Migration
  def self.up
    create_table :membership_volunteer_category_joins do |t|
      t.integer :membership_id
      t.integer :volunteer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :membership_volunteer_category_joins
  end
end
