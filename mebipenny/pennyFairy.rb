# <h1>The Penny Fairy</h1>
# <p>Your friend JT has a problem. Every morning when he unlocks his car, he
# finds new pennies in his cupholder and ketchup packets scattered
# everywhere. He's not sure who's putting them there or how they're doing
# it -- only he has a key -- but that's not actually what he's worried
# about. JT is concerned that eventually he won't be able to fit his Soylent
# travel mug in the cupholder.</p>

# <p>He's started tallying how many pennies are left every night, and has
# discovered that it depends on how many were there before; it grows by
# a constant factor. This growth rate may not be an integer, but the number
# of pennies always will be (rounding up when necessary), e.g.
# 18 -&gt; 27 -&gt; 41 -&gt; 62 ...</p>

# <p>JT has also calculated how many pennies can go in the cupholder before
# the mug won't fit. He just needs to figure out how long he can safely wait
# before removing the pennies.</p>

# <p>Given the penny count from yesterday, the penny count from today, and a
# maximum penny capacity, calculate the minimum number of days it will
# take the penny population to meet or exceed the capacity.</p>

# <h3 id="example">Example</h3>

# <p>STDIN:</p>

# <pre><code>
# 1
# 10
# 10000</code></pre>

# <p>STDOUT:</p>

# <pre><code>3</code></pre>

# <h3>Example</h3>

# <p>STDIN:</p>

# <pre><code>
# 4
# 6
# 20</code></pre>
# 6 (day 0), 9 (day 1), 14 (day 2), 21 (day 3)

# <p>STDOUT:</p>

# <pre><code>3</code></pre>


# inputs three lines, 
# first line is yesterday's penny count
# second line is today's penny count
# third line is total capacity


# output is an integer 



def predict(arg)
	factor = (arg[1].to_f / arg[0].to_f)
	pennyCount = arg[1].to_i
	cupCapacity = arg[2].to_i
	i = 0

	while cupCapacity > pennyCount do
		pennyCount = (pennyCount * factor).ceil
		i += 1
	end
	i
end




test1 = ["1", "10", "10000"]
test2 = ["4", "6", "20"]


puts predict(test1)
puts predict(test2)