# in
# 2 0 0 3 0 4

# which looks like
#           |
#       |   |
# |     |   |
# | _ _ | _ |

# out
# 7

# in
# 0 4 4 2 3

# which looks like
#   | |  
#   | |   |
#   | | | |
# _ | | | |

# out
# 1

# given an input of wall heights, calculate how many units
# of liquid may be stored / retained


####################

class Thing
	# def initialize(inputString)
	# 	# this doesn't work, it always returns the object instead of the intended return value
	# 	# weird
	# 	walls = inputString.split(" ").map(&:to_i)
	# 	maximalPeeks = calculatePeeks(walls)
	# 	return calculateRetention(maximalPeeks, walls)
	# end

	def doThing(inputString)
		walls = inputString.split(" ").map(&:to_i)
		maximalPeeks = calculatePeeks(walls)
		calculateRetention(maximalPeeks, walls)
	end


	def calculateRetention(maximalPeeks, walls)
		calculateBowlVolumes(maximalPeeks, walls).reduce(:+)
	end


	def calculatePeeks(walls)
		maximizePeeks(findPeeks(walls))
	end


	def maximizePeeks(peeks)
		checkBack = peeks.length

		peeks.push(nil)
		i = 0

		while i < checkBack do
			if secondPeekShorter?(peeks[i+1],peeks[i]) && secondPeekShorter?(peeks[i-1],peeks[i])
				peeks[i] = nil
			end
			i+=1
		end

		peeks = peeks.compact

		if peeks.length != checkBack
			peeks = maximaizePeeks(peeks)
		end
		peeks
	end


	def secondPeekShorter?(peek1, peek2)
		if peek1 == nil
			false
		elsif peek2 == nil
			true
		elsif peek1[:height] > peek2[:height]
			true
		elsif peek1[:height] <= peek2[:height]
			false
		end
	end
	

	def secondWallShorter?(wall1, wall2)
		if wall1 == nil
			false
		elsif wall2 == nil
			true
		elsif wall1 >= wall2
			true
		elsif wall1 < wall2
			false
		end
	end


	def findPeeks(walls)
		size = walls.length
		walls.push(nil)

		peeks = []
		i = 0

		while i < size do
			if secondWallShorter?(walls[i], walls[i-1]) && secondWallShorter?(walls[i], walls[i+1])
				peeks << {index: i, height: walls[i]}
			end
			i+=1
		end

		peeks.compact
	end


	def calculateBowlVolumes(maximalPeeks, walls)
		bowlVolumes = []
		maximalPeeks.each_with_index do |peek, index|

			if maximalPeeks[index+1]
				waterLevel = measureDepth(maximalPeeks, peek, index)
				span = walls[measureSpan(maximalPeeks, peek, index)]

				if span.length > 0
					bowlVolumes << soundTheBottom(waterLevel, span)
				end
			end
		end
		bowlVolumes
	end


	def measureDepth(maximalPeeks, peek, index)
		if maximalPeeks[index+1][:height] >= peek[:height]
			peek[:height]
		elsif maximalPeeks[index+1][:height] < peek[:height]			
			maximalPeeks[index+1][:height]
		end
	end


	def measureSpan(maximalPeeks, peek, index)
		(peek[:index]+1)...maximalPeeks[index+1][:index]
	end


	def soundTheBottom(waterLevel, span)
		span.map{ |wallHeight| waterLevel - wallHeight}.reduce(:+)
	end

end




#####################

test1 = "0 4 4 2 3"
test2 = "2 0 0 3 0 4"

# th = Thing.new(test1)
# puts th

th = Thing.new
puts th.doThing(test1)
puts th.doThing(test2)