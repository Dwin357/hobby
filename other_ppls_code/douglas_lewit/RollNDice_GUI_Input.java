/** This Java program computes all the possible sums of rolling a certain number of six-sided dice.  But the sums 
are not all equally likely.  For more than one die the distribution of the frequencies actually follows a normal 
distribution.  This was definitely a fun little project to work on.  The probabilities and statistics of various 
games of chance can provide computer programmers with various interesting challenges and programming projects. */

import java.util.HashMap;

import javax.swing.JOptionPane;

public class RollNDice_GUI_Input
{
    public static void main(String[ ] args)
    {
		// The default for n is 2.  Most people like to roll 2 dice.  But the user can enter any integer he wants.
		// If the user enters an integer greater than 12, it's going to take a long time for the program to execute.
		String n = JOptionPane.showInputDialog( null, "How many dice do you want to throw?", "2" );

		// The String "2" has to be parsed into an int.
		int N = Integer.parseInt(n);

		System.out.println( );

		HashMap <Integer, Integer> frequencies = new HashMap <Integer, Integer> ( ) ;

        int minimumSum = N;

		int maximumSum = 6*N;

		for( int k = minimumSum; k <= maximumSum; k++ )
	    	frequencies.put(k, 0);

		int[ ] diceRolls = new int[N];

		addDice( 0, N, diceRolls, frequencies );

		System.out.println( "If you roll " + N + " dice, these are the sums and their respective frequencies:" );

		System.out.println( );

		for( int k = minimumSum; k <= maximumSum; k++ )
	    	{
				System.out.print( "For the sum of " + k + " the frequency is:" );

				System.out.print( "\t" + frequencies.get(k) );

				System.out.println( );
	    	}

		System.out.println( );

		String hashmap = "{";

		for( int k = minimumSum; k <= maximumSum - 1; k++ )
	    	hashmap+= " " + k + ": " + frequencies.get(k) + ", ";

		hashmap+= maximumSum + ": " + frequencies.get(maximumSum) + " ";

		hashmap+= "}";

		System.out.println( "The frequencies of the sums printed out in the form of a Python dictionary:" );

		System.out.println( hashmap );

		System.out.println( );

    } // End of the main method.

    public static void addDice(int i, int n, int[ ] array, HashMap <Integer, Integer> f)
    {
        int k = 0;

		if( i == n )
	    {
			k = sumArray( array );

			f.put(k, f.get(k).intValue( ) + 1);
	    }
		else
	    	for( array[i] = 1; array[i] <=6; array[i]++ )
				addDice(i + 1, n, array, f);

    } // End of the addDice method.

    public static int sumArray( int[ ] array )
    {
		int len = array.length, sum = 0;

		for( int j = 0; j < len; j++ )
	    	sum+= array[j];

		return sum;

    } // End of the sumArray method.

} // End of the class RollNDice_GUI_Input.


