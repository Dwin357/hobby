Program ATM challenge

this program should do the following
-it reads in a csv file of accounts and transactions
-it outputs a list of ending account standings and unresolved transactions
-it is fully tested

example input
John Smith, 3757, $600.00   # acct name, acct num, acct balance
4832, 3757, 50.00           # acct to rcv, acct to send, amount xfrd
Jane Doe, 4832, $900
4832, 1111, 100
Eric Shawn, 1337, $50
3757, 1337, 100

example output
Accounts
John Smith:   $550.00
Jane Doe:     $1050.00 ($950.00)
Eric Shawn:   -$50.00 ($50.00)

Unresolved
4832:1111, $100.00, unkn act:1111
3757:1337, $100.00, insuf funds
