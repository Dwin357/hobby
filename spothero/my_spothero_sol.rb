require 'json'
require 'time'
require 'active_support/time'

class LookUpTable

	attr_reader :table

	def initialize(rate_json)
		@table = set_table(rate_json)
	end


	def set_table(rates)
		rates_data = JSON.parse(IO.read(rates))
		rtn = [[], [], [], [], [], [], []]

		rates_data["rates"].each do |price_block|
			times = price_block["times"].split("-").map{|time| elapsed_min_of_day(time) }
		
			price_block["days"].split(",").each do |day|
				day = day_to_int(day)
				rtn[day] << {start: times[0], 
										stop: times[1], 
										rate: price_block["price"], 
										range: (times[0]...times[1]+60)}
			end
		end
		rtn
	end


	def elapsed_min_of_day(string)
		num = string.to_i
		hr = num / 100
		min = num % 100
		(hr*60) + min
	end


	def day_to_int(day)
		case day
		when "sun"
			0
		when "mon"
			1
		when "tues"
			2
		when "wed"
			3
		when "thurs"
			4
		when "fri"
			5
		when "sat"
			6
		end
	end


	def find_next_price_break(timeObject)
		breakTime = nil

		table[timeObject.wday].each do |rate|
			if rate[:range].include?(elapsed_minutes(timeObject))
				hr = (rate[:stop] / 60) + 1
				min = rate[:stop] % 60 
				breakTime = Time.parse("#{hr}:#{min}", timeObject)
			end
		end
		breakTime
	end

	
	def look_up_price(timeObject)
		time = elapsed_minutes(timeObject)
		price = "unavailable"
		table[timeObject.wday].each do |rate|
			price = rate[:rate] if rate[:range].include?(time)
		end
		price
	end

	def elapsed_minutes(time)
		(60 * time.hour) + time.min
	end

	def sum_total_cost(start_time, end_time)
		# this looks up the price @ the start time
		# this compares if the next price break is before / after the end time
		# if after, it returns :: rate*(end time - start time)
		# if before, it returns :: rate*(break time - start time) + sum_total_cost(break_time, end_time)


		rate = look_up_price(start_time)
		if rate == "unavailable"
			return rate
		end

		next_price_jump = find_next_price_break(start_time)
		if next_price_jump > end_time




	end









	def testOutput
		p @table
	end

end

jsonFile = ARGV[0]
startDate = DateTime.parse(ARGV[1])
endDate = ARGV[2]

table = LookUpTable.new(jsonFile)

# table.testOutput

p table.look_up_price(startDate)



# so what are you trying to do.
# I want to be able to enter a time range, and know if there are any price breaks w/in the range
# then, I want a table that lets me enter a time a returns a price
# finally, I want a multiplier which sums the price for a period

