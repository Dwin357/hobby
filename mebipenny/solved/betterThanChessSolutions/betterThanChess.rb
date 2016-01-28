class GoGoFunction




# <h1>It's Totally Better Than Chess</h1>
# <p>Go is an amazing game of strategy and cunning where players
# take turns placing colored stones on a board to try to surround more territory
# than their opponent.</p>
# <p>Playing it is really fun. Scoring it is really tedious.</p>
# <p>Build a program that can take the serialized state of
# a Go board and output the final score according to the following rules:</p>
# <p>1) A space with a stone on it is not worth any points.<br />
# 2) spaces are contiguous if they are related horizontally or vertically (not diagonally)<br />
# 3) Each cell of space inside a contiguous region of spaces surrounded by a single<br />
# color of stones is worth one point for that color. (being against a wall is the same<br />
#  as being surrounded)<br />
# 4) Each cell of space that is in a contiguous regions of spaces that is touched by<br />
# both black and white stones is neutral, and worth points for neither player.<br />
# 5) Boards are not bounded, but will always be a square (3x3, 5x5, 6x6, 9x9, 25x25, etc)<br />
# 6) Each row of input is a row on the board.<br />
# 7) Each cell is delimited by spaces<br />
# 8) B = a black stone, W = a white stone, _ = an empty space</p>
# <p>Sample input:</p>
# <pre><code>
# B _ _ _
# B B B B
# W W W W
# W _ _ W</code></pre>
# <p>Sample output (black is always listed first):</p>
# <pre><code>
# Black: 3
# White: 2</code></pre>
# <p>Automate the scoring, and you can spend more time playing!</p>



# functional attempt







class GoGoState
	attr_reader :board, :boardEdge
	def initialize(inputString)
		@board = setBoard(inputString)
		@boardEdge = Math.sqrt(@board.length).to_i
		@leaderBoard = {"B"=>0, "W"=>0}
	end

	def setBoard(input)
		input.map{|line| line.split(" ")}.flatten
	end

	def score
		removeForfeitStones
		collectTerritories.each do |territory|
			scoreTerritory(territory)
		end
		render
	end

	def removeForfeitStones
		# how the fuck do you do this?
		# I mean the obvious is that you have an "identify eyes" method and an "is surrounded" method
	end

	def scoreTerritory(territory)
		surroundingPositions = []
		surroundingColors = {}

		territory.each do |position|
			surroundingPositions = surroundingPositions | findCardinals(position)
		end

		surroundingPositions = surroundingPositions.reject do |position|
			territory.include?(position)
		end

		surroundingPositions.each do |position|
			surroundingColors[@board[position]] = 1
		end

		if surroundingColors.length == 1
			surroundingColors.each do |color, v|
				@leaderBoard[color] += territory.length
			end
		end
	end

	def render
		puts "Black: #{@leaderBoard["B"]}"
		puts "White: #{@leaderBoard["W"]}"
	end

	def collectTerritories
		territories = []
		board.each_with_index do |position, index|
			if position == "_"
				territories << expandTerritory(index)
			end
		end
		territories
	end

	def expandTerritory(index)
		@board[index] = "X"
		territory = [index]

		cardinals = findCardinals(index)
		cardinals.each do |cardinalIndex|
			if @board[cardinalIndex] == "_"
				territory = territory | expandTerritory(cardinalIndex)
			end
		end
		territory
	end

	def findCardinals(position)
		[ findUp(position), 
			findDown(position), 
			findRight(position), 
			findLeft(position)
		].compact
	end

	def findUp(position)
		return nil if position < boardEdge
		position - boardEdge
	end

	def findDown(position)
		return nil if (position + boardEdge + 1) > @board.length
		position + boardEdge
	end

	def findRight(position)
		return nil if ((position+1) % boardEdge) == 0
		position +1
	end

	def findLeft(position)
		return nil if (position % boardEdge) == 0
		position - 1
	end

end

test1 = [
"B _ _ _",
"B B B B",
"W W W W",
"W _ _ W"
]

test2 = [
"B _ _ B _",
"B B B B W",
"W W W W _",
"W _ _ W _"
]

test3 = [
"_ B _ W _",
"B B B B B",
"W W W W B",
"W _ _ W W",
"W B _ W _"
]



puts "test 1"
scoreBot = GoGoState.new(test1)
scoreBot.score

puts "test 2"
scoreBot = GoGoState.new(test2)
scoreBot.score

puts "test 3"
scoreBot = GoGoState.new(test3)
scoreBot.score