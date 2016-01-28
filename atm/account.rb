class Account
  attr_accessor :name, :number, :nominalBalance, :avaliableBalance
  def initialize(input)
    args = buildArgs(input)
    @name             = args[:name]
    @number           = args[:number]
    @nominalBalance   = args[:balance]
    @avaliableBalance = args[:balance]
  end

  def buildArgs(csv_line)
    {:name => csv_line[0],
     :number => csv_line[1],
     :balance => csv_line[2].gsub(/[^\d\.]/, '').to_f}
  end


end


