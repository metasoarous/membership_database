# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :member do |f|
  f.membership_id 1
  f.first_name "MyString"
  f.last_name "MyString"
  f.phone "MyString"
  f.email "MyString"
  f.notes "MyText"
end
