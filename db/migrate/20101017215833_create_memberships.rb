class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.string :mailing_address
      t.string :home_address
      t.string :phone
      t.string :email
      t.integer :number
      t.string :city
      t.string :state
      t.string :state
      t.integer :zip
      t.string :best_contact
      t.text :volunteer_skills

      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
