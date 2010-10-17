# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :membership do |f|
  f.mailing_address "MyString"
  f.home_address "MyString"
  f.phone "MyString"
  f.email "MyString"
  f.number 1
  f.city "MyString"
  f.state "MyString"
  f.state "MyString"
  f.zip 1
  f.best_contact "MyString"
  f.volunteer_skills "MyText"
end
