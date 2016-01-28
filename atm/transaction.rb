class Transaction
  @@transactionCounter = 1

  attr_accessor :sender, :receiver, :amount, :resolved, :transactionNumber, :timeStamp

  def initialize(input)
    args = buildArgs(input)
    @transactionNumber = Transaction.newTransactionNumber
    @sender            = args[:sender]
    @receiver          = args[:receiver]
    @amount            = args[:amount]
    @resolved          = false
  end

  def buildArgs(line)
    { :receiver => line[0],
      :sender => line[1],
      :amount => line[2].gsub(/[^\d\.]/, '').to_f}
  end

  #######  class  ##########

  def self.newTransactionNumber
    number = @@transactionCounter
    @@transactionCounter += 1
    number
  end

end