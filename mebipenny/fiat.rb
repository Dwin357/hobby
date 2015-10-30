# in
# 225
# 105 buy
# 102 hold
# 101 hold
# 106 sell
# 102 buy
# 107 sell

# out
# 231

# Rules
# first line is starting cash
# all transactions are for a single coing
# never spend more cash than you have
# never sell more bitcoins than you have

class Account
	def initialize
		@transactionHistory = []
		@cash = 0
		@coins = 0
	end

	def transaction(action)
		@transactionHistory << action
		processTransaction(action)
	end

	def processTransaction(action)
		transaction = action.split(" ")
		amount = transaction[0].to_i

		case transaction[1]
		when nil
			@cash += amount
		when "buy"
			@cash -= amount
			@coins += 1
		when "sell"
			@cash += amount
			@coins -= 1
		end


	end

	def cashBalance
		@cash
	end

end

test = [
"225",
"105 buy",
"102 hold",
"101 hold",
"106 sell",
"102 buy",
"107 sell"]

bittyBank = Account.new

test.each do |line|
  bittyBank.transaction(line)
end

puts bittyBank.cashBalance



