# A ._            N _.
# B _...          O ___
# C _._.          P .__.
# D _..           Q __._
# E .             R ._.
# F .._.          S ...
# G __.           T _
# H ....          U .._
# I ..            V ..._
# J .___          W .__
# K _._           X _.._
# L ._..          Y _.__
# M __            Z __..

# # in
# .__..__._..._

# # out
# ADGBT
# ADGDA
# ADGDET
# ADGNEA
# ADGNEET
# ...
# WUTLET
# WUTREA
# WUTREET
# WUTRIT
# WUTRU

# given a string of mores code, print all 



# So, talk to me...  
# The thing this is describing to me is a combination iterative & recursive strategy
# Iteration goes through the key hash and tries to match

# So how would you do this if you were working with just a single word
# 	I would go through using regex, if the letter matches I would shift it off
# 		recurse the process until a full word is generated or it is shown to be a deadend (remainder doesn't match any letters)
# 			if matching, shovel word into return
# 			if !, move on to the next one
# 		after recursion hits bottom on one path, have it back out and go down the next leg, and so on until it a full list


# So, based on that, the pattern I am seeing is a tree where all the leaves are either deadends or possible words







class LetterNode
	attr_reader :moreString, :letter
	attr_accessor :pointer

	def initialize(moreString, letter="")
		@moreString = moreString
		@letter = letter
		@pointer = []
	end
end


class WordTree

	def initialize(moreString)
		@key = setKey
		@root = LetterNode.new(moreString)
		addBranchesTo(@root)
		collectLeaves
	end

	def addBranchesTo(node)
		codeWord = node.moreString
		puts codeWord
		@key.each do |letter, mores|
			# this isn't getting into the regex...  not clear why - also brain fried
			if match = codeWord.match(/(\Amores)(.*)/)
				puts "there"
				remainingMores = match[2]
				child = LetterNode.new(remainingMores, letter)
				node.pointer << child
				if remainingMores.length > 0
					addBranchesTo(child)
				end
			end
		end
	end

	def collectLeaves
		rtn = []
		i = 0
		@root.pointer.each do |node|
			i+=1
		end
		puts i
	end

	def setKey
		{
			"A" => "._",
			"B" => "_...",
			"C" => "_._.",
			"D" => "_..",
			"E" => ".",
			"F" => ".._.",
			"G" => "__.",
			"H" => "....",
			"I" => "..",
			"J" => ".___",
			"K" => "_._",
			"L" => "._..",
			"M" => "__",
			"N" => "_.",
			"O" => "___",
			"P" => ".__.",
			"Q" => "__._",
			"R" => "._.",
			"S" => "...",
			"T" => "_",
			"U" => ".._",
			"V" => "..._",
			"W" => ".__",
			"X" => "_.._",
			"Y" => "_.__",
			"Z" => "__.."
		}
	end
end









##############

# def process(line)
#   # Process each line of input here
#   return WordTree.new(line)
# end

# $stdin.each_line do |line|
#   puts process(line)
# end



line = ".__..__._..._"
WordTree.new(line)
