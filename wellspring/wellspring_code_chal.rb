
#uses ruby '2.2.2'
require 'csv'


class Table

	def initialize
		@headers = []
		@rows = []
	end


	# format text
	def add_headers(line)
		line.each_with_index do |header, i|
			column_header = header.strip.split("_").each(&:capitalize!).join(" ")

			@headers[i] = {header: column_header,
											spacing: column_header.length}
		end 
	end

	def add_row(line)
		ary = []
		line.each_with_index do |cell, i|
			word = cell.strip
			ary << word
			update_header_spacing(word, i)
		end
		@rows << ary
	end

	def update_header_spacing(word, i)
		if @headers[i][:spacing] < word.length
			@headers[i][:spacing] = word
		end
	end


	# organize text
	def alphabatize_by_column(num)
		@rows = @rows.sort_by{ |row| row[num] }
	end


	# print text with spacing
	def display
		display_headers
		@rows.each do |row|
			display_row(row)
		end
	end

	def display_headers
		column_headers = ""
		underscores = ""

		@headers.each do |col|
			column_headers += col[:header]

			count = col[:header].size
			count.times do
				underscores += "-"
			end

			remainder = col[:spacing] - count + 3
			remainder.times do
				column_headers += " "
				underscores += " "
			end
		end

		puts column_headers
		puts underscores
	end

	def display_row(row)
		output = ""
		row.each_with_index do |cell, i|
			output += cell

			remainder = @headers[i][:spacing] - cell.size + 3
			remainder.times do
				output += " "
			end
		end
		puts output
	end

end




# grab info from user & stage table
csv_file_path = ARGV[0]
tbl = Table.new

# populate table w/ csv data (auto formats text)
i = 0
CSV.read(csv_file_path).each do |line|
	if i == 0
		tbl.add_headers(line)
	else
		tbl.add_row(line)
	end
	i += 1
end

tbl.alphabatize_by_column(2)
tbl.display