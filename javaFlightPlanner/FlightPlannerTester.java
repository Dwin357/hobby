import java.util.Scanner;
import java.io.IOException;

class FlightPlannerTester {
    public static void main() throws IOException{
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter graph input file name: ");
        //String file = sc.nextLine();
        String file = "flightRoutes.txt";
        System.out.println("flightRoutes.txt");
        FlightPlanner testCase = new FlightPlanner(file);
        testCase.printFlightRoutes();
    }
}