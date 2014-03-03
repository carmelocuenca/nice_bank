class Account
  attr_reader :balance

  def credit(amount)
    @balance = amount
  end

  def debit(amount)
    @balance -= amount
  end
end

class CashSlot
  def contents
    @contents or raise "I'm empty!"
  end

  def dispense(amount)
    @contents = amount
  end
end

class Teller
  def initialize(cash_slot)
    @cash_slot = cash_slot
  end

  def withdraw_from(account, amount)
    account.debit(amount)
    @cash_slot.dispense(amount)
  end
end

require 'sinatra'
set :cash_slot, CashSlot.new
set :account do
  fail 'account has not been set'
end

get '/' do
  %{
  <html>
    <body>
      <form action="/withdraw" method="post">
        <label for="amount">Amount</lable>
        <input type="text" id="amount" name="amount">
        <button type="submit">Withdraw</button>
      </form>
    </body>
  </html>
  }
end

post '/withdraw' do
  teller = Teller.new(settings.cash_slot)
  teller.withdraw_from(settings.account, params[:amount].to_i)
end


