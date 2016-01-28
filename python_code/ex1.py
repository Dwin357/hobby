# print "Hello World"
# print 'this is single quote'
# print "I'd much rather 'not'."
# print 'I "said" do not touch this.'

# # print "Is this a comment?"
# print "post comment"

# ### exercise 2  #####
# print "hens", 25+30/3
# print "roosters", 100-25*3%4
# print "eggs"
# print 3+2+1-5+4%2-1/4+6
# print "true?"
# print 3+2<5-7

#### exercise 3  ######

# name = "dwin"
# age = 35
# height = 69
# weight = 225
# eyes = "green"
# teeth = "straight"
# hair = "dark"

# print "Let's talk about %s." % name
# print "He is %d inches tall" % height
# print "He is %d pounds heavy" % weight
# print "He's got %s eyes and %s hair" % (eyes, hair)
# print "If I add %d, %d, and %d I get %d" % (age, height, weight, age + height + weight)


#### exercise 4  ######
# x = "There are %d types of people." % 10
# binary = "binary"
# do_not = "don't"
# y = "Those who know %s and those who %s." % (binary, do_not)

# print x
# print y

# print "I said: %r." % x
# print "I also said: '%s'." % y

# hilarious = False
# joke_evaluation = "Isn't that joke so funny?! %r"

# print joke_evaluation % hilarious

# w = "This is the left side of..."
# e = "a string with a right side."

# print w + e

## this is kind of cool; joke_eval has a nested interpilation

# top_lvl = "this is top level and moving to, %s.  Getting off at floor %s"
# second_lvl = "one level down: at %s & moving %s"

# six = "six"
# five = "five"
# four = "four"
# three = "three"
# two = "two"
# one = "one"

# print top_lvl % (second_lvl % (six, second_lvl % (five, second_lvl% (four, second_lvl % (three, second_lvl % (two, "nowhere"))))), one)

# print "A" * 3
# print 3 * "A"
# # both of these work, in ruby 3*"A" throws error --string can't be coerced into fixnum--

# print "cat"[1] == "a"
# print "cat" + "dog" == "catdog"
# # these both eval to true

# var = """
# a multi-line string
# strats with three quotes
# and ends the same way.
# this also seems to start
# and end with a newline
# """
# newline = "jan\nfeb\nmarch\noct\nnov\ndec"
# print var
# print newline

# for x in range(0,100000):
#     for i in ["/","-","|","\\","|"]:
#         print "%s\r" % i,

#### exercise 5  ######
# print "How old are you?",
# age = int(raw_input())
# print "How tall are you?",
# height = raw_input()
# print "How much do you weigh?",
# weight = raw_input()

# print "So, you're %r old, %r tall and %r heavy." % (
#     age, height, weight)

# age = int(raw_input("How old are you? "))
# height = raw_input("How tall are you? ")
# weight = raw_input("How heavy are you? ")
# print "so your: %r old, %r tall, and %r heavy." % (age, height, weight)

#### exercise 6  ######

# from sys import argv

# script, first, second, third = argv

# print "The script is called:", script
# print "Your first variable is:", first
# print "Your second variable is:", second
# print "Your third variable is:", third

# # this errors if there are too many OR too few arguments for argv

from sys import argv

script, user_name = argv
prompt = '> '

print "Hi %s, I'm the %s script." % (user_name, script)
print "I'd like to ask you a few questions."
print "Do you like me %s?" % user_name
likes = raw_input(prompt)

print "Where do you live %s?" % user_name
lives = raw_input(prompt)

print "What kind of computer do you have?"
computer = raw_input(prompt)

print """
Alright, so you said %r about liking me.
You live in %r.  Not sure where that is.
And you have a %r computer.  Nice.
""" % (likes, lives, computer)

#### exercise 7  ######
#### exercise 8  ######
#### exercise 3  ######
#### exercise 3  ######