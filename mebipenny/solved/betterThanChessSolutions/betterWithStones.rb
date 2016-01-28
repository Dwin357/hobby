# so I have written one program that scores territories using state
# I've written a second (cleaner) program that scores territories using pass thrus
# now I want a third that removes non-viable stones (scoring them 1:1) & then socres remaining territories

# my idea is to basically use a lot of the code from my functional program, except have it expand out "formations" -ie chains of stones, which can be tested for existing w/in another formation





class GoGoStones

	def score(gameInput)
		board = setBoard(gameInput)

		renderScore(
			scoreTennibleFormations(
				scoreUntennibleStones(
					buildFormations(board),
					board
				),
				board
			)
		)
	end

	def setBoard(gameInput)
		gameInput.map{|line| line.split(" ")}.flatten
	end

	def buildFormations(board)
		# so this is now more complicated
		# what does this return?
		# I imagine this creates a hash which has 
		board
	end

	def scoreUntennibleStones(formations, board)
		formations
	end

	def scoreTennibleFormations(tennibleFormations, board)
		tennibleFormations
	end		

	def renderScore(leaderBoard)
		p leaderBoard
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


scoreBot = GoGoStones.new

puts "test 1"
scoreBot.score(test1)
puts

# puts "test 2"
# scoreBot.score(test2)
# puts

# puts "test 3"
# scoreBot.score(test3)





# select - Nick
# private held
# outsource therapy services
# 8k ee, glenview milwaukee district metra
# 60 onsite (+2 open jr dev rails)
# face to face (1hr technical interview) & white board
# meet with 


# apps

# resperitory - web app for documentation 
	# tablet cross over

# on boarding app

# access mng (o-auth)









# For Avalon
#  - I'm basically applying for the noSQL DB position
#  - although I think it would be cool to grow onto the semantic modeler position

# Company looks like it grew out of TX, although it is making a hard push in Chi-central

# Douge might be the person to talk


# - front end
# - noSQL :: teach, JS

# init interview
# tech assesment :: code chal? / white board
# 	consultant :: 
# meet mng :: area
# ph convo ceo / owner