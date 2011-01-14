class AddFuzzyDateToRenewal < ActiveRecord::Migration
  def self.up
    add_column :renewals, :fuzzy_date, :boolean
  end

  def self.down
    remove_column :renewals, :fuzzy_date
  end
end
