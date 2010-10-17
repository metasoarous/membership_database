class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.integer :membership_id
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
