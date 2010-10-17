# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :renewal do |f|
  f.date "2010-10-17"
  f.payment_amount 1.5
  f.barter false
  f.notes "MyText"
  f.membership_id 1
end
