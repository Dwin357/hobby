require 'json'
require 'time'

class LookUpTable

	attr_reader :table

	def initialize(rates)
		@table = set_table(rates)
	end


	def set_table(rates)
		rate_data = JSON.parse(IO.read(rates))
		rtn = [[], [], [], [], [], [], []]

		rate_data["rates"].each do |price_block|
			price_block["days"].split(",").each do |day|
				day = day_to_int(day)
				rtn[day] << {range: format_string_time_range(price_block["times"]),
										rate: price_block["price"]}
			end
		end
		rtn
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


	def look_up_price(startTime, stopTime)
		price = "unavaliable"
		startT = dateTime_to_float(startTime)
		stopT = dateTime_to_float(stopTime)

		return price if !same_day?(startTime, stopTime)

		table[startTime.wday].each do |rate|
			if rate[:range].include?(startT) && rate[:range].include?(stopT)
				price = rate[:rate] 
			end
		end
		price
	end


	def same_day?(timeOne, timeTwo)
		timeOne.yday == timeTwo.yday && timeOne.wday == timeTwo.wday
	end


	def dateTime_to_float(dateTime)
		dateTime.hour.to_f + (dateTime.min.to_f / 100)
	end


	def format_string_time_range(times)
		rng = times.split("-").map do |time|
			format_string_time(time)
		end
		rng[0]...rng[1]
	end


	def format_string_time(time)
		time.insert(-3, ".").to_f
	end


end


jsonFile = ARGV[0]
startDate = DateTime.parse(ARGV[1])
endDate = DateTime.parse(ARGV[2])

table = LookUpTable.new(jsonFile)
puts table.look_up_price(startDate, endDate)