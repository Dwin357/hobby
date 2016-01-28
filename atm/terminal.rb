require 'csv'
require_relative "account"
require_relative "transaction"

class Terminal
  attr_accessor :accounts, :transactions, :unresolvedTransactions
  def initialize(filePath = "./testFiles")
    @accounts = []
    @transactions = {}
    parseData(filePath)
    # resolveTransactionsds
  end

  def parseData(filePath)
    Dir["#{filePath}/*"].each do |file|
      CSV.foreach(file) do |csv_line|
        p csv_line
        interpretCSVLine(csv_line)
      end
    end
  end

  def resolveTransactions
  end

  def interpretCSVLine(csv_line)
    if lineIsAccount?(csv_line)
      addAccount(csv_line)
    else
      addTransaction(csv_line)
    end
  end

  def lineIsAccount?(line)
    # assumes that account numbers are are four digits long
    # assumes 0000 is not a valid account number
    # these assumptions should be tested for
    test = line[0]
    test.length != 4 && test.to_i == 0
  end

  def addAccount(line)
    accounts << Account.new(line)
  end

  def addTransaction(line)
    transactions[:unresolved] = [] unless transactions[:unresolved]
    transactions[:unresolved] << Transaction.new(line)
  end


end

# p CSV::Row.new(["","",""], ["John Smith", "3757", "$600.00"])
# t = Terminal.new