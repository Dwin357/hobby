# <h1>Fantastic Four</h1>
# <h2 id="tic-tac-toe">Tic-Tac-Toe++!</h2>

# <p>Ah, that children's classic, the board game that almost feels like it's
# strategic when you're 6 years old. Unfortunately, playing an expanded version
# on an unbounded board with other 6 year olds is tedious,
# as they keep insisting they've won when the game is clearly not over.</p>

# <p>Let's automate away the problem of having to manually crush the dreams of children with
# your superior scoring ability.</p>

# <h3 id="constraints">Constraints</h3>

# <p>The input will always be a square 2 dimensional matrix of cells
# (comma delimited within rows, each row is delimited by a new line), each cell having
# a value that is one of &quot;B&quot; (black), &quot;R&quot; (red), or &quot;_&quot; (empty). Each point is placed
# once and may never be moved or changed for the remainder of the game.</p>

# <h3>Example</h3>

# <p>STDIN:</p>

# <pre><code>B,B,R,_,R
# B,_,R,_,R
# _,B,B,_,R
# B,_,R,_,_
# B,B,R,_,R</code></pre>

# <p>The above game has no win condition fulfilled currently.<br />

# A Win condition exists when there are 4 cells consecutively in any direction
# (horizontally, vertically, diagonally) that have the same non-empty value (only
#  B or R). A win condition, when identified, is conveyed by the output &quot;Win_[winning_color]&quot;
#  as the first line, with the top-left-most (prioritize top over left) coordinate of the winning sequence
# on the second line as "[row,column]". Zero-based indexing, top left is the origin.
# </p>

# <p>
# A game with no current winner should output &quot;Unsettled&quot; as the first line,
# with the count of remaining empty cells on the board as the second line.
# </p>

# <p>A game with no <em>possible</em> wins from here forward should output &quot;Draw&quot;, with the count of remaining empty cells on the board as the second line.</p>

# <p>Because play is turn based, there will never be a game state where there is
# more than one win condition on the board. The program should return &quot;Invalid&quot;
# in this case, with the top-left-most coordinate of each win sequence on each following line, ordered
# from the top left by row.
# </p>

# <h3 id="horizontal-win">Horizontal win:</h3>

# <p>STDIN:</p>

# <pre><code>B,B,R,_,R
# B,_,R,_,R
# _,B,B,B,B
# B,_,R,_,_
# B,B,R,_,R</code></pre>

# <p>STDOUT:</p>

# <pre><code>Win_B
# [2,1]</code></pre>

# <h3 id="vertical-win">Vertical Win</h3>

# <p>STDIN:</p>
# <pre><code>B,B,R,_,R,_
# B,_,R,_,R,B
# _,B,R,B,B,R
# B,_,R,_,_,_
# B,B,B,_,R,_
# B,R,_,_,R,_</code></pre>

# <p>STDOUT:</p>
# <pre><code>Win_R
# [0,2]</code></pre>

# <h3 id="diagonal-win">Diagonal Win</h3>

# <p>STDIN:</p>
# <pre><code>_,_,_,_,_,_,_,_,_,_
# _,_,_,_,_,_,_,_,_,_
# _,_,_,_,_,_,_,_,_,_
# _,_,_,_,_,B,_,_,_,_
# _,_,_,_,B,_,_,_,_,_
# _,_,_,B,_,_,_,_,_,_
# _,_,B,_,_,_,_,_,_,_
# _,_,_,_,_,R,R,R,_,_
# _,_,_,_,_,_,_,_,_,_
# _,_,_,_,_,_,_,_,_,_</code></pre>

# <p>STDOUT:</p>

# <pre><code>Win_B
# [3,5]</code></pre>

# <h3 id="unfinished">Unfinished</h3>

# <p>STDIN:</p>
# <pre><code>B,B,R,_,R
# B,_,R,_,R
# _,B,B,_,R
# B,_,R,_,_
# B,B,R,_,R</code></pre>

# <p>STDOUT:</p>
# <pre><code>Unsettled
# 9</code></pre>

# <h3 id="complete-draw">Complete Draw</h3>
# <p>STDIN:</p>
# <pre><code>B,R,B,R
# R,R,B,B
# B,B,R,R
# R,B,R,B</code></pre>
# <p>STDOUT:</p>

# <pre><code>Draw
# 0</code></pre>

# <h3 id="inevitable-draw">Inevitable Draw</h3>
# <p>STDIN:</p>
# <pre><code>B,B,R,R,B,B,_,R,B,R
# B,B,R,B,B,B,R,B,R,B
# R,R,B,R,R,B,B,R,R,B
# B,R,B,R,R,R,B,R,B,B
# _,B,B,R,B,B,B,R,R,R
# R,R,R,B,_,R,R,B,R,R
# R,B,B,R,R,B,R,B,R,B
# B,R,R,R,B,R,R,R,B,_
# R,B,B,B,R,_,B,R,B,B
# B,_,R,B,B,R,_,B,R,R</code></pre>
# <p>STDOUT:</p>

# <pre><code>Draw
# 7</code></pre>

# <h3 id="invalid-state">Invalid State</h3>
# <p>STDIN:</p>
# <pre><code>B,R,B,R
# B,R,B,R
# B,R,B,R
# B,R,B,R</code></pre>
# <p>STDOUT:</p>

# <pre><code>Invalid
# [0,0]
# [0,1]
# [0,2]
# [0,3]</code></pre>

# <p>Now get out there and show those kids who's boss.</p>



