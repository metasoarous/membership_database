class CreateVolunteerCategories < ActiveRecord::Migration
  def self.up
    create_table :volunteer_categories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :volunteer_categories
  end
end
