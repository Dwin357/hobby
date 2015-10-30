# this is falling into an infinite loop somewhere, 
# not clear to me where / why


class CrabCannon
  def initialize
    @pairs = [[[], []]]
    @input = []
  end
  
  def read(line)
    @input << line
  end
  
  def fire
    loadInput
    lightCannon
  end
  
  
  def lightCannon
    rtn = []
    @pairs.each do |pair|
      rtn << evaluate(pair)
    end
    puts rtn
  end
  
  def loadInput
    # @pairs = [
    #         pair1 = [
    #             music1 = [line, line,...],
    #             music2 = [line, line,...]
    #           ],
    #         pair2 = [],
    #         ...
    # ]

    i = 0
    j = 0
    @input.each_with_index do |line, index|
      if (index+1)%12 == 0 && j%2 == 1
        i += 1
        j = 0
        @pairs[i] = [[], []]
      elsif (index+1)%12 == 0
        j = 1
      else
        @pairs[i][j] << line
      end
    end
  end
  
  
  def expandNotes(music)
    music.map do |line|
      resonance = 0
      line.split("").map do |beat|
        if resonance > 0
          resonance -=1
          "1"
        elsif beat.to_i == 0
          beat
        else
          resonance = beat.to_i
          "1"
        end
      end.join
    end
  end 
  
  
  def evaluate(pair)
    puts "eval"
    musicA = expandNotes(pair[0])
    musicB = expandNotes(pair[1]).reverse
    range = musicA.length
    i = 0
    
    if musicA.length != musicB.length
      return "no" 
    end
    
    while i < range do 
      if musicA[i] != musicB[i]
        return "no" 
      end
      i += 1
    end
    
    "yes"
  end
  
end




##########

crabPirate = CrabCannon.new


# def process(line)
#   # Process each line of input here
#   return line
# end

$stdin.each_line do |line|
  crabPirate.read(line)
end

crabPirate.fire

##########

# crabPirate = CrabCannon.new


# def process(line)
#   # Process each line of input here
#   return line
# end

# $stdin.each_line do |line|
#   crabPirate.read(line)
# end

# crabPirate.fire


############

test1 = [
"1          ",
"-1---------",
"  1        ",
"---1-------",
"    1      ",
"-----1-----",
"      1    ",
"-------1---",
"        1  ",
"---------1-",
"          1",
"/n",
"          1",
"---------1-",
"        1  ",
"-------1---",
"      1    ",
"-----1-----",
"    1      ",
"---1-------",
"  1        ",
"-1---------",
"1          ",
"/n",
"     ",
"-----",
"     ",
"-----",
"     ",
"-----",
"    1",
"---1-",
"  1  ",
"-1---",
"1    ",
"/n",
"     ",
"-----",
"     ",
"-----",
"     ",
"-----",
"    1",
"---1-",
"  1  ",
"-1---",
"1    "
]

test2 = [
"    ",
"----",
"  2 ",
"----",
"    ",
"----",
"    ",
"----",
"    ",
"2---",
"    ",
"/n",
"    ",
"----",
"2   ",
"----",
"    ",
"----",
"    ",
"----",
"    ",
"--2-",
"    "
]

crabPirate = CrabCannon.new


# $stdin.each_line do |line|
#   crabPirate.read(line)
# end

test2.each do |line|
  crabPirate.read(line)
end

crabPirate.fire