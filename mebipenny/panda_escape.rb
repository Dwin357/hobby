def process(line)
  # Process each line of input here
  cloud = line.shift.to_i
  princess = line.shift.to_i
  return "NO SOLUTION" if princess_overweight?(cloud, princess)

  guards = line.map(&:to_i)
  remaining_space = cloud - princess
  escort = most_guards(remaining_space, guards)

  return build_return(escort)
end


def build_return(escort)
	rtn = ""
	escort.each do |guard|
		rtn += (guard.to_s + " ") 
	end
	rtn.strip
end


def most_guards(free_space, guards)	
	num_escorts = guards.length
	roster = []

	while num_escorts > 0 do
		guards.combination(num_escorts).to_a.each do |posibility|
			if posibility.reduce(:+) == free_space
				roster << posibility
			end
		end
		break if roster.length > 0
		num_escorts -= 1
	end

	biggest_guard(roster)
end


def biggest_guard(possible_rosters)
	selected_group = []
	biggest_guard = 0

	possible_rosters.each do |group|
		if group.max > biggest_guard
			selected_group = group.sort
			biggest_guard = group.max
		end
	end

	selected_group
end


def princess_overweight?(cloud, princess)
	princess > cloud
end


$stdin.each_line do |line|
  puts process(line)
end




# [0] is cloud capacity
# [1] is princess weight
# optimize [2+] to take most remaining, then heaviest
# guard order needs to be lightest -> heaviest


# # in
# test1 = ["800", "200", "200", "400", "210", "300", "190"]
# test2 = ["300", "300", "100"]
# test3 = ["300", "200", "80", "60", "20", "40"]
# test4 = ["200", "210", "80", "120"]

# # out
# 210 200 190

# 80 20
# NO SOLUTION

# puts process(test1)
# puts process(test2)
# puts process(test3)
# puts process(test4)