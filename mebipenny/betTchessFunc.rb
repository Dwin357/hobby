class GoGoFunction
	# so, ya; do that thing but in a functional way
	# start by declaring the variables you will need w/in scope
	# pattern 1, waterfall :: have a standard data type handed forward from each method to the next until your result falls out the back
	# pattern 2, incrementtors :: methods increment in-scope local var

	def score(gameInput)
		board = setBoard(gameInput)

		render(
			scoreTerritories(
				collectTerritories(
					identifyTerritories(board)
				), 
				board
			)
		)
	end

	def render(leaderBoard)
		puts "Black: #{leaderBoard["B"]}"
		puts "White: #{leaderBoard["W"]}"
	end

	def surroundingIndexs(territory, edge)
		territory.map{|pos| findCardinals(pos, edge)}.reduce(:|) - territory
	end

	def scoreTerritories(territories, board)
		edge = Math.sqrt(board.length).to_i
		leaderBoard = {}

		territories.each do |territory|
			surroundingColors = {}
			surroundingIndexs(territory, edge).each do |position|
				surroundingColors[board[position]] = 1
			end

			if surroundingColors.length == 1
				surroundingColors.each do |color, v|
					if leaderBoard[color]
						leaderBoard[color] += territory.length
					else
						leaderBoard[color] = territory.length
					end
				end
			end
		end
		leaderBoard
	end


	def setBoard(gameString)
		gameString.map{|line| line.split(" ")}.flatten
	end


	def collectTerritories(territoryIndexs)

		return [] if territoryIndexs.compact.length == 0
		territories = territoryIndexs
		continuing = true

		while continuing do
			reference = territories.clone
			territories = compressTerritories(territories)

			if reference == territories
				continuing = false
			end
		end
		territories.compact
	end


	def compressTerritories(territories)
	# imagined initial input [[0], [1], [2], [3], nil, [5],  nil, nil, nil], 
	# 	where the nils are stones and everything else is a single element array = to its index position
	# imagined function output [[0, 1], nil, [2, 3], nil, nil, [5], nil, nil, nil]
	# 	the indexs are clumped together into territories, and their old index positions are replaced by nils.  The process is repeated by #collect until no further compression occurs

		return territories if territories.compact.length == 1
		i = territories.length
		edge = Math.sqrt(i).to_i

		while i > 0 do
			if territories[i]
				surroundingIndexs(territories[i], edge).each do |cardinalIndex|
					if territories[cardinalIndex]
						territories[i] << cardinalIndex
						territories[cardinalIndex] = nil
					end
				end
			end
			i -=1
		end
		territories
	end

	def identifyTerritories(board)
		territories = []
		board.each_with_index do |position, index|
			if position == "_"
				territories[index] = [index]
			else
				territories[index] = nil
			end
		end
		territories
	end

	def findCardinals(position, edge)
		[ findUp(position, edge), 
			findDown(position, edge), 
			findRight(position, edge), 
			findLeft(position, edge)
		].compact
	end

	def findUp(position, boardEdge)
		return nil if position < boardEdge
		position - boardEdge
	end

	def findDown(position, boardEdge)
		return nil if (position + boardEdge + 1) > boardEdge**2
		position + boardEdge
	end

	def findRight(position, boardEdge)
		return nil if ((position+1) % boardEdge) == 0
		position +1
	end

	def findLeft(position, boardEdge)
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


scoreBot = GoGoFunction.new

puts "test 1"
scoreBot.score(test1)
puts

puts "test 2"
scoreBot.score(test2)
puts

puts "test 3"
scoreBot.score(test3)

# puts "test 2"
# scoreBot = GoGoState.new(test2)
# scoreBot.score

# puts "test 3"
# scoreBot = GoGoState.new(test3)
# scoreBot.score