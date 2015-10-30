# She suggests using the following scheme:

# Only the letters A-Z are used. There are no spaces.
# If a letter appears just once, encode the letter as-is, so CAT becomes CAT.
# If a letter is repeated, encode the letter as the letter followed by the number
# of times it repeats, so CAAAATTT becomes CA4T3.
# Your program must accept lines of text and output for each the same line of text encoded according to the scheme above.

# in
# AABZZZZQQJ
# SHAZBOT
# BQQRRRRRRZ
# BBBQTTTTTTF

# out
# A2BZ4Q2J
# SHAZBOT
# BQ2R6Z
# B3QT6F

##########



#########

def process(line)
  rtn = []
  line.split("").each do |char|
  	if rtn[-1] == char
  		rtn << 2
  	elsif rtn[-1] == nil || rtn[-1].to_i == 0
  		rtn << char
  	elsif rtn[-2] == char
  		rtn[-1] += 1
  	else
  		rtn << char
  	end
  end
  return rtn.join
end

# $stdin.each_line do |line|
#   puts process(line)
# end


test1 = "AABZZZZQQJ"
test2 = "SHAZBOT"
test3 = "BQQRRRRRRZ"
test4 = "BBBQTTTTTTF"

puts process(test1)
puts process(test2)
puts process(test3)
puts process(test4)

# out
# A2BZ4Q2J
# SHAZBOT
# BQ2R6Z
# B3QT6F