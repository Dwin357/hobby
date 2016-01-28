import java.util.Scanner;
import java.io.IOException;

class FlightPlannerRunner {
    public static void main(String[] args) throws IOException{
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter graph input file name: ");
        FlghtPlanner planner = new FlightPlanner(sc.nextLine());
        System.out.println(">>");
        Sting command = sc.nextLine();
        while 
    }
    
    public static void runFlightPlannerRunnerTestMethods() throws IOException{
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter graph input file name: ");
        //String file = sc.nextLine();
        String file = "testData.txt";
        System.out.println("testData.txt");
        FlightPlanner testCase = new FlightPlanner(file);
        testCase.printFlightRoutes();
        System.out.println("input file text: 'Graph: AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7' ");
        System.out.println("Ans: Output #1: 9, Output #2: 5, Output #3: 13, Output #4: 22, Output #5: NO SUCH ROUTE");
        System.out.println("Ans:  Output #6: 2, Output #7: 3, Output #8: 9, Output #9: 9, Output #10: 7");
        System.out.println();
        System.out.println("1. Calculate fuel use :: Input 'A-B-C' into fuelLoadForTrip: " + testCase.fuelLoadForTrip("A-B-C"));
        System.out.println("2. Calculate fuel use :: Input 'A-D' into fuelLoadForTrip: " + testCase.fuelLoadForTrip("A-D"));
        System.out.println("3. Calculate fuel use :: Input 'A-D-C' into fuelLoadForTrip: " + testCase.fuelLoadForTrip("A-D-C"));
        System.out.println("4. Calculate fuel use :: Input 'A-E-B-C-D' into fuelLoadForTrip: " + testCase.fuelLoadForTrip("A-E-B-C-D"));
        System.out.println("5. Calculate fuel use :: Input 'A-E-D into fuelLoadForTrip': "  + testCase.fuelLoadForTrip("A-E-D"));
        System.out.println("6. Calculate #roundtrips up to n layovers :: Input 'C', 3 into countRoundTripFlightsUpToNLayovers: " + testCase.countRoundTripFlightsUpToNLayovers("C", 3));
        System.out.println("7. Calculate #linear flights w/ exactly n layovers :: Input 'A', 'C', 4 into countLinearFlightsExactlyNLayovers: " + testCase.countLinearFlightsExactlyNLayovers("A", "C", 4));
        System.out.println("8. FW Calculate most efficient A -> B :: Input 'A', 'C' into fuelForFWOptimizedLinearFlight: " + testCase.fuelForFWOptimizedLinearFlight("A", "C"));
        System.out.println("9. FW Calculate shortest distance A -> A :: Input 'B' into fuelForFWOptimizedRoundTrip: " + testCase.fuelForFWOptimizedRoundTrip("B"));
        System.out.println("10. Calculate #roundtrips using up to X fuel:: Input 'C', 30 into countRoundTripFlightsUpToXFuelLoad: " + testCase.countRoundTripFlightsUpToXFuelLoad("C", 30));
        
    }
}