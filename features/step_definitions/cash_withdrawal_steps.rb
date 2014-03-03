CAPTURE_CASH_AMOUNT_NUMBER = Transform  /^(\$)(\d+)$/ do |currency_symbol, digits|
  digits.to_i
end

World(KnowsTheUserInterface)

Given /^my account has been credited with (#{CAPTURE_CASH_AMOUNT_NUMBER})$/ do |amount|
  my_account.credit(amount)
end

When /^I request (#{CAPTURE_CASH_AMOUNT_NUMBER})$/ do |amount|
  teller.withdraw_from(my_account, amount)
end

Then /^(#{CAPTURE_CASH_AMOUNT_NUMBER}) should be dispensed$/ do |amount|
  cash_slot.contents.should eq(amount)
end

Then /^the balance of my account should be (#{CAPTURE_CASH_AMOUNT_NUMBER})$/ do |amount|
  my_account.balance.should eq(amount), "Expected the balance to be #{amount} but it was #{my_account.balance}"
end
