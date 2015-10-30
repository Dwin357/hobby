
#uses ruby '2.2.2'
require 'csv'


class Table

	attr_reader :spacing

	def initialize
		@spacing = []
		@headers = []
		@rows = []
	end


	# format text
	def add_headers(line)
		line.each_with_index do |header, i|
			@headers[i] = header.strip.split("_").each(&:capitalize!).join(" ")
			@spacing[i] = @headers[i].length
		end 
	end

	def add_row(line)
		ary = []
		line.each_with_index do |cell, col|
			word = cell.strip
			ary << word
			update_spacing(word, col)
		end
		@rows << ary
	end

	def update_spacing(word, col)
		if @spacing[col] < word.length
			@spacing[col] = word.length
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
		headers_row = ""
		underscores = ""
		@headers.each_with_index do |column_name, column_number|
			name_size = column_name.size
			headers_row += column_name
			name_size.times do
				underscores += "-"
			end
			headers_row += padding(name_size, column_number)
			underscores += padding(name_size, column_number)
		end
		puts headers_row
		puts underscores
	end

	def display_row(row)
		output = ""
		row.each_with_index do |cell, column_number|
			output += cell
			output += padding(cell.size, column_number)
		end
		puts output
	end

	def padding(word_length, col)
		margin = " | "
		rtn = ""
		(@spacing[col] - word_length).times do
			rtn += " "
		end
		unless (col+1) == @headers.size
			rtn += margin
		end
		rtn
	end

end




# grab info from user & stage table
csv_file_path = ARGV[0]
option = ARGV[1]
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

if (option != nil) && (option.to_i < tbl.spacing.length)
	tbl.alphabatize_by_column(option.to_i)
end

tbl.display