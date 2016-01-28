import java.util.ArrayList;
import java.io.File;
import java.util.Scanner;
import java.io.IOException;
import java.io.FileNotFoundException;

/**
 * Prompt
 * You have been asked to write a planning program for an airline.
 * this program needs to:
 * When provided with the file, your program needs to read in a directed graph of airliner fuel usage
 * When provided with a series of airports (ie "A-B-C") provide the total fuel usage for the trip, or "NO SUCH TRIP" if it is not possible
 * When provided with two airports (ie "A", "B") provide the fuel usage for the most efficient path between them, or "NO.."
 * When provided with two airports (ie "A", "B") provide the num of layover it takes to connect them by the most direct path
 * When provided with one airport (ie "C") provide the fuel usage for the most efficient loop
 * When provided with one airport (ie "C") provide the num of layovers it takes make a loop by the most direct path
 * When provided with two airports and a number of layovers (ie "A", "C", 3) provide how many unique flight paths there are from A to C with exactly 3 layovers
 * When provided with two airports and a fuel amount (ie "A", "C", 4) provide how many unique flight paths there are from A to C which use less than 4 hundred gallons of fuel
 *      note both AC and ACDC would be considered unique flight paths for this
 *      
 *  Input
 *  An example of file text is: "Graph: AB9, CD3, BC8..." 
 *  where the first letter is the departure airport, the second letter is the arival airport, 
 *  and the number is how many gallons of fuel is needed for the flight (in hundreds of gallons)
 *  
 *  Importantly
 *  -the name of an airport will always begin with a capital letter
 *  -due to travel patterns, a flight from A -> B does not imply a flight from B -> A
 *  -due to wind patterns, a flight from A -> B might use a different amount of fuel than B -> A
 *  -every flight from A -> B will need to be loaded with the same amount of fuel (all edges have a single weight)
 * 
 * 
 */
class FlightPlanner
{
    // instance variables - replace the example below with your own
    ArrayList<Airport> flightRoutes = new ArrayList<Airport>();
    FloydWarshallOptimizedConnections graph;

    /**
     * Constructor for objects of class FlightPlanner
     */
    public FlightPlanner(String filePath) throws FileNotFoundException
    {
       ArrayList<String[]> routes = parseRoutesFromFile(filePath);
       for(String[] route : routes){
           addRouteToFlightRoutes(route);
        }
        this.graph = new FloydWarshallOptimizedConnections(this.flightRoutes);
    }
    
    private ArrayList<String[]> parseRoutesFromFile(String filePath) throws FileNotFoundException{
        // goes through the file and returns an ArrayList of strings of the file data
        
        ArrayList<String[]> routes = new ArrayList<String[]>();
        Scanner sc = new Scanner(new File(filePath));
        sc.next();  // this gets rid of the "graph" label at the begining
        while (sc.hasNext()){
            routes.add( formatFileLine( sc.next() ) );
        } 
        return routes;
    }
    
    private String[] formatFileLine(String fileLine){
        String[] args = fileLine.split("(?=\\d+)");
        String[] formatedData = args[0].split("(?=[A-Z])");
        String temp = "";
        for(int i=1; i < args.length; i++){
            if(args[i].endsWith(",")){
                temp = temp + args[i].substring(0,1);
            } else {
                temp = temp + args[i];
            }
        }
        
        String[] rtn = new String[3]; // {origin, destination, fuelLoad}
        rtn[0] = formatedData[0];
        rtn[1] = formatedData[1];
        rtn[2] = temp;
        return rtn;
    }
    
    private void addRouteToFlightRoutes(String[] route){
        // route = {origin, destination, fuelLoad}
        String origin = route[0];
        String destination = route[1];
        int fuelLoad = Integer.parseInt(route[2]);
        
        Airport airport = findOrCreateAirport(origin);
        airport.addConnection(destination, fuelLoad);        
    }
    
    private Airport findOrCreateAirport(String city){
       Airport airport = getAirport(city);
       if(airport == null){
           airport = new Airport(city);
           flightRoutes.add(airport);
       }
       return airport;
    }
    
    private Airport getAirport(String city){
       for(Airport airport : flightRoutes){
            if(airport.name().equals(city)){
                return airport;
            }
       }
       return null;
    }
    
    public void printFlightRoutes(){
        for (Airport airport : flightRoutes){
            airport.printAirport();
            System.out.println("\n");
        }
    }
    
    private int calculateTripFuelLoad(String trip){
        String[] stops = trip.split("-");
        int totalFuelLoad = 0;
        
        for(int i=0; i< stops.length-1; i++){
            String currentLocation = stops[i];
            String nextLocation = stops[i+1];
            int fuelUsed = calculateLegFuelLoad(currentLocation, nextLocation);
            
            if (fuelUsed == -1){
                return -1;
            }
            
            totalFuelLoad += fuelUsed;
        }
        return totalFuelLoad;
    }
    
    private int calculateLegFuelLoad(String origin, String destination){
        Airport leavingFrom = getAirport(origin);
        Connection connection = leavingFrom.getConnections();
        while(connection != null && !connection.name().equals(destination)){
            connection = connection.next();
        }
        if(connection == null || !connection.name().equals(destination)){
            return -1;
        } else {
            return connection.fuelLoad();
        }
    }
    
    public String fuelLoadForTrip(String trip){
        return display(calculateTripFuelLoad(trip));
    }
    
    private String display(int returnNumber){
        if(returnNumber == -1){
            return "NO SUCH FLIGHT";
        } else {
            return Integer.toString(returnNumber);
        }
    }
    
    private ArrayList<Integer> tripDistances(String origin, String destination, int layovers){
        ArrayList<String> routes = new ArrayList<String>();
        for(; layovers > 1; layovers--){
            routes.addAll(fixedNumberOfLayoversRecursiveSearch(0, layovers, origin, destination, ""));
        }
        
        ArrayList<Integer> secondHanoiTower = new ArrayList<Integer>();
        for(String route : routes){
            secondHanoiTower.add(calculateTripFuelLoad(route));
        }
        return secondHanoiTower;
    }
    
    private ArrayList<String> fixedNumberOfLayoversRecursiveSearch(int finalLayover, String currentLocation, String destination){
        return fixedNumberOfLayoversRecursiveSearch(0, finalLayover, currentLocation, destination, "");
    }
    
    private ArrayList<String> fuelLoadRecursiveSearch(int totalFuelLimit, String currentLocation, String destination){
        return fuelLoadRecursiveSearch(0, totalFuelLimit, currentLocation, destination, "");
    }
   
    private ArrayList<String> fixedNumberOfLayoversRecursiveSearch(int currentLayover, int finalLayover, String currentLocation, String destination, String pastLayovers){
        ArrayList<String> possibleFlightRoutes = new ArrayList<String>();
        Airport location = getAirport(currentLocation);
        String pathTraveled = setPathTraveled(pastLayovers, currentLocation);
        
        if(currentLayover == finalLayover){
            if(currentLocation.equals(destination)){
                possibleFlightRoutes.add(pathTraveled);
            }
        } else {
            for(Connection con = location.getConnections(); con != null; con = con.next()){
                possibleFlightRoutes.addAll( fixedNumberOfLayoversRecursiveSearch(currentLayover+1, finalLayover, con.name(), destination, pathTraveled));
            }
        }
        return possibleFlightRoutes;
    }
    
    private ArrayList<String> fuelLoadRecursiveSearch(int currentFuelUsed, int totalFuelLimit, String currentLocation, String destination, String pastLayovers){
        ArrayList<String> possibleFlightRoutes = new ArrayList<String>();
        Airport location = getAirport(currentLocation);
        String pathTraveled = setPathTraveled(pastLayovers, currentLocation);
        
        if(currentFuelUsed < totalFuelLimit){
            if(currentLocation.equals(destination)){
                possibleFlightRoutes.add(pathTraveled);
            }
            for(Connection con = location.getConnections(); con != null; con = con.next()){
                int spentFuel = currentFuelUsed + con.fuelLoad();
                possibleFlightRoutes.addAll( fuelLoadRecursiveSearch(spentFuel, totalFuelLimit, con.name(), destination, pathTraveled));
            }
        }
        return possibleFlightRoutes;
    }
    
    public String countRoundTripFlightsUpToXFuelLoad(String origin, int xFuelLoad){
        // the minus 1 is b/c the search method includes starting and ending at an airport w/out leaving as a "roundtrip"
        return display( fuelLoadRecursiveSearch(xFuelLoad, origin, origin).size() -1);
    }
    
    public String countRoundTripFlightsUpToNLayovers(String origin, int nLayovers){
        ArrayList<String> roundTrips = new ArrayList<String>();
        for(; nLayovers > 1; nLayovers --){
            roundTrips.addAll( fixedNumberOfLayoversRecursiveSearch(nLayovers, origin, origin));
        }
        return display(roundTrips.size());
    }
    
    public String countLinearFlightsExactlyNLayovers(String origin, String destination, int nLayovers){
        return display( fixedNumberOfLayoversRecursiveSearch(nLayovers, origin, destination).size());        
    }
    
    
    private String setPathTraveled(String pastLayovers, String currentLocation){
        if (pastLayovers == ""){
            return currentLocation;
        }else{
            return pastLayovers+"-"+currentLocation;
        }
    }
    
    public String fuelForFWOptimizedLinearFlight(String origin, String destination){
        return display(graph.mostEfficientLinearFlight(origin, destination));
    }
    
    public String fuelForFWOptimizedRoundTrip(String origin){
        return display(graph.mostEfficientRoundTrip(origin));
    }
    
    //////////////////////  Class Methods for Testing  /////////////////////////////////////

    public static void testFlightPlanner(){
        System.out.println(testFormatFileLine()+ ":formatFileLine() works");
        System.out.println(testParseRoutesFromFile() + ":parseRoutesFromFile() works");
        System.out.println(testAddRouteToFlightRoutes() + ":addRouteToFlightRoutes() works");
        System.out.println(testGetAirport() + ":getAirport() works");
        System.out.println(testFindOrCreateAirport() + ":findOrCreateAirport() works");
        System.out.println(testCalculateLegFuelLoad() + ":calculateLegFuelLoad() works");
    }
    
    static boolean testFormatFileLine(){
        String fileLineMiddleEntry = "OriginDestination500,";
        String fileLineEndEntry = "OriginDestination500";
        String[] expectedReturn = {"Origin", "Destination", "500"};
        Airport testObject = new Airport("flightRoutes.txt");
        
        /// Grrr, why isn't this not recognizing the method?
        //String[] testCase1 = testObject.formatFileLine(fileLineMiddleEntry);
        //String[] testCase2 = testObject.formatFileLine(fileLineEndEntry);
        //return testCase1==expectedReturn && testCase2==expectedReturn;
        return false;
    }
    
    static boolean testAddRouteToFlightRoutes(){
        return false;
    }
    
    static boolean testGetAirport(){
        return false;
    }
    
    static boolean testFindOrCreateAirport(){
        return false;
    }
    
    static boolean testParseRoutesFromFile(){
        return false;
    }
    
    static boolean testCalculateLegFuelLoad(){
        return false;
    }
}