############  chal 1 ###############
def hex_to_base64_digest(hexdigest)
  [[hexdigest].pack("H*")].pack("m0")
end

input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"

output = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

#puts hex_to_base64_digest(input) == output

###################### chal 2 ##################

input1 = "1c0111001f010100061a024b53535009181c"
input2 = "686974207468652062756c6c277320657965"
output = "746865206b696420646f6e277420706c6179"

test1 = 18
test2 = 20
testOutput = "110"



def chal2(input1, input2)
  puts var1 = input1.each_byte.map{|b| b.to_s(16)}.join 
  puts var2 = input2.each_byte.map{|b| b.to_s(16)}.join
  var1 ^ var2

  #hex_to_base64_digest(input1) ^ hex_to_base64_digest(input2)
end

#puts chal2(input1, input2) #== output
# puts chal2(test1, test2)

# puts (a=18).to_s(2)
# puts (b=20).to_s(2)
# puts (a ^ b).to_s(2)

#############   chal 3  ############################

testString = "this is my sample text, I sure do hope it is a good test"

def frequencyTester(string)
  string.split("").each_with_object({}) do |char, hash|
    if hash[char]
      hash[char] += 1
    else
      hash[char] = 1
    end
  end
end

p frequencyTester(testString)

