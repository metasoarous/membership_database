class CreateMemberVolunteerCategoryJoins < ActiveRecord::Migration
  def self.up
    create_table :member_volunteer_category_joins do |t|
      t.integer :member_id
      t.integer :volunteer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :member_volunteer_category_joins
  end
end
