class CreateRenewals < ActiveRecord::Migration
  def self.up
    create_table :renewals do |t|
      t.date :date
      t.float :payment_amount
      t.boolean :barter
      t.text :notes
      t.integer :membership_id

      t.timestamps
    end
  end

  def self.down
    drop_table :renewals
  end
end
