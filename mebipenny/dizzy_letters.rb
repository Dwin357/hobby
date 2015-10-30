

class Picture

	def initialize
		@picture = []
	end

	def wipe
		@picture = []
	end

	def add_line(line)
		ln = line.split("")
		picture << ln
	end

	def rotate
		turns = calculate_rotation
		turns.times do
			rotate_ninety
		end
	end

	def calculate_rotation
		rotation_factor = picture.shift.join.to_i
		rotation_factor / 90
	end

	def rotate_ninety
		i = 0
		max_width = picture.map(&:length).max
		rtn = []

		while (i < max_width) do
			ln = []
			picture.reverse.each do |line|
				if line[i]
					ln << line[i]
				else
					ln << " "
				end
			end
			rtn << ln
			i+= 1
		end
		@picture = rtn
	end


	def render
		picture.each do |line|
			puts line.join
		end
	end

	private
	attr_accessor :picture

end


pic = Picture.new

$stdin.each_line do |line|
	pic.add_line(line)
end

pic.rotate
pic.render
pic.wipe

# this isn't passing 3 cases... not sure what / why
# this works exactly as I expect it to...  without more feedback as to why the remaining three don't pass I don't have a path forward
# t = Picture.new

# test1 = 
# ["90",
# "0...0",
# ".0.0.",
# "..0..",
# "..0..",
# "..0..",
# "..0.."]

# test1.each do |line|
# 	t.add_line(line)
# end
# t.rotate
# puts "90"
# t.render
# t.wipe
# puts

# test2 = 
# ["180",
# "0...0",
# ".0.0.",
# "..0..",
# "..0..",
# "..0..",
# "..0.."]

# test2.each do |line|
# 	t.add_line(line)
# end
# t.rotate
# puts "180"
# t.render
# puts
# t.wipe

# test3 = 
# ["270",
# "0...0",
# ".0.0.",
# "..0..",
# "..0..",
# "..0..",
# "..0.."]

# test3.each do |line|
# 	t.add_line(line)
# end
# t.rotate
# puts "270"
# t.render
# puts
# t.wipe


# test4 = 
# ["90",
# "0...0",
# " 0.0",
# "  0",
# "  0",
# "  0",
# "  0"]

# test4.each do |line|
# 	t.add_line(line)
# end
# t.rotate
# puts "padding"
# t.render
# puts
# t.wipe