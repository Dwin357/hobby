import java.util.ArrayList;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;


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
public class FlightPlanner
{
    // instance variables - replace the example below with your own
    

    /**
     * Constructor for objects of class FlightPlanner
     */
    public FlightPlanner()
    {
       String input = "thisIsMyCamelCase12";
       String[] test = input.split("(?=\\d+(\\.\\d+)?)");
  //     String[] test = input.split("(?=[A-Z])");
       for(int i = 0; i < test.length; i++){
           System.out.println(test[i]);
        }
        
    }
    
}

class Airport
/**
 * The root of a linked list which will keep track of the connections for each airport
 */
{
    private String name;
    private Connection connections;
    
    public Airport(String _name){
        name = _name;
        connections = null;
    }
    
    public void setConnections(Connection _connection){
        connections = _connection;
    }
    
    public Connection getConnections(){
        return connections;
    }
}

class Connection
/**
 * The node of a linked list which will keep track of the connections for each airport
 */
{
    private String name;
    private int distance;
    private Connection nextConnection;
    
    public Connection(String _name, int _distance){
        name = _name;
        distance = _distance;
    }
    
    public String name(){
        return name;
    }
    
    public int distance(){
        return distance;
    }
    
    public void setNext(Connection _connection){
        nextConnection = _connection;
    }
    
    public Connection next(){
        return nextConnection;
    }
    
    
}

class FloydWarshallConnection
{
    
    
}




////////////////////////////////////////////////////////////////////////////////////////  example   ///////////////////////////////////////////////////////
/*
 * import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;
import java.util.ArrayList;

class Connection {
    public char stationName;
    public Connection next;
    public int distance;
    public Connection(char waypoint, Connection neighbor, int journey){
        this.stationName = waypoint;
        next = neighbor;
        this.distance = journey;
    }
 }
 
 class Station {
     char name;
     Connection connectionList;
     Station(char name, Connection connections){
         this.name = name;
         this.connectionList = connections;
     }
 }
 
 class FloydWarshall {
    char[] nodeName;
    int [][] pathWeight;
    int infinite = 9999;
           
    FloydWarshall(ArrayList<Station> trainTable){
        // this is basically making a look up table
        setNodeName(trainTable);
        setPathWeight(trainTable);
        optimizeConnections();
        
    }
    
    public int shortestPath(char origin, char destination){
        return pathWeight[getIndexOf(origin)][getIndexOf(destination)];
    }
    
    public int shortestLoop(char location){
        // this works off the idea that, after all other paths are optimized the risk of infinite loops is no longer present
        // so the most efficient loop path may be devised by reassigning the center line from 0 to infinite and reoptimizing
        resetOriginToInfinite();
        return pathWeight[getIndexOf(location)][getIndexOf(location)];
    }
    
    public int altShortestLoop(char location){
        // this works by assuming that the most efficient loop from a given point will be to some other loop and directly back
        // therefore, given a graph of the most efficient point to point paths, this checks the distance to and from each other point
        // (with a special if statement to exclude cking itselg) and returns the distance of the shortest round trip
        int rtn = infinite;
        int loc = getIndexOf(location);
        
        for (int i = 0; i < nodeName.length; i++){
            if(loc != i){
                if(rtn > pathWeight[loc][i] + pathWeight[i][loc]){
                    rtn = pathWeight[loc][i] + pathWeight[i][loc];
                }
            }
        }
        return rtn;
    }
    
    
    
    
    private void resetOriginToInfinite(){
        for(int i = 0 ; i < nodeName.length; i++){
            pathWeight[i][i] = infinite;
            optimizeConnections();
        }
    }
    
    private void setNodeName (ArrayList<Station> trainTable){
        nodeName = new char [trainTable.size()];
        int i = 0;        
        for (Station station : trainTable){
            nodeName[i] = station.name;
            i = i+1;
        }
    }
    
    private void setPathWeight(ArrayList<Station> trainTable){
        pathWeight = new int[nodeName.length][nodeName.length];
        
        for(Station origin : trainTable){
            int i = getIndexOf(origin);
            
            for(int j = 0; j < nodeName.length; j++){
              char destination = nodeName[j];
                
              if(i == j){
                  pathWeight[i][j] = 0;
                } else if (hasConnection(origin, destination)){
                    pathWeight[i][j] = connectionWeight(origin,destination);
                } else {
                    pathWeight[i][j] = infinite;
                }
             }            
        }
    }
    
    private void optimizeConnections(){
        // this ticks through the stations
        for(int i =0; i < nodeName.length; i++){
            
            // this ticks through the connection for each station
            for (int j = 0; j < nodeName.length; j++){
                
                // this needs to ck for alternate paths, and substitute if the alternate is more efficient
                for (int k = 0; k < nodeName.length; k++){
                    if(pathWeight[i][j] > pathWeight[i][k] + pathWeight[k][j]){
                        pathWeight[i][j] = pathWeight[i][k] + pathWeight[k][j];
                    }
                }
            }
        }
    }
    
    private int connectionWeight(Station origin, char destination){
        for(Connection con = origin.connectionList; con != null; con=con.next){
            if(con.stationName == destination){
                return con.distance;
            }
        }
        return -1;
    }
    
    private boolean hasConnection(Station origin, char destination){
        for(Connection con = origin.connectionList; con != null; con=con.next){
            if(con.stationName == destination){
                return true;
            }
        }
        return false;
    }
          
      private int getIndexOf(char station){
          for(int i = 0; i < nodeName.length; i++){
              if(station == nodeName[i]){
                  return i;
                }
            }
            return -1;
        }
        
        private int getIndexOf(String station){
            char loc = station.charAt(0);
            return getIndexOf(loc);
        }
        
        private int getIndexOf(Station station){
            char loc = station.name;
            return getIndexOf(loc);
        }
    }
    
 public class FloydWTrainStudy {
       ArrayList<Station> trainTable = new ArrayList<Station>();
     
      // constructor sets up an arraylist of stations, each holding a linked list of connections
    public FloydWTrainStudy(String file) throws FileNotFoundException{
        Scanner sc = new Scanner(new File(file));
        ArrayList<String> edgeList = new ArrayList<String>();
        
        // this gets rid of the "graph" label at the begining
        sc.next();
        
        while (sc.hasNext()){
            edgeList.add(sc.next());
        }
        
        for (String edge : edgeList) {
            boolean exists = false;
            Connection nextStop;
            char origin = edge.charAt(0);
            char destination = edge.charAt(1);
            int distance;
            Station departingStation = new Station(origin, null);            
            
            // chomp trailing comma & chng edge weight into int
            if (edge.endsWith(",")){
                distance = Integer.parseInt(edge.substring(2, edge.length() -1));
            }
            else {
                distance = Integer.parseInt(edge.substring(2, edge.length()));
            }

            // scan trainTable to see if station exists
            // this should be refactored out as it will be needed by other methods
            for (Station leftFrom : trainTable){
                if(leftFrom.name == origin){
                    exists = true;
                    departingStation = leftFrom;
                }
            }
            
            if(!exists){
                trainTable.add(departingStation);
            }
            
            addConnection(departingStation, destination, distance);
        }
    }

     
    // solves for problems 1 - 5 && used for distance calculations in problems 8 - 10
    private int calculateTrip(String plan){
        String[] stops = plan.split("-");
        int rtn = 0;
        
        for (int i=0; i < stops.length-1; i++){
            char current = stops[i].charAt(0);
            char next = stops[i+1].charAt(0);
            int traveled = calculateDistance(current, next);
            
            // guard against invalid trips
            if (traveled == -1){
                return -1;
            }
            
            // update return value
            rtn = rtn + traveled;
        }
        return rtn;
    }
    
    // solves 6
     public String countLoopTripsLimitStops(String station, int stops){
         char loc = station.charAt(0);
         ArrayList<String> paths = new ArrayList<String>(); 
        for(; stops > 1; stops--){
             paths.addAll(exactLevelRecursiveSearch(0, stops, loc, loc, ""));
        }
         return display(paths.size());
        }
        
     // solves 7
     public String countLineTripsExact(String departure, String destination, int stops){
         char from = departure.charAt(0);
         char to = destination.charAt(0);
         ArrayList<String> paths = exactLevelRecursiveSearch(0, stops, from, to, "");
         return display(paths.size());
        }
    
     // alternate for solving 8 using Floyd Warshall
     public String fWShortestDistanceTripsLine(String departure, String destination){
         char from = departure.charAt(0);
         char to = destination.charAt(0);
         FloydWarshall fw  = new FloydWarshall(trainTable);
         return display(fw.shortestPath(from, to));
        }
     
    // alternative for solving for 9 using Floyd Warshall
    public String fwshortestDistanceTripsLoop(String station){
        char loc = station.charAt(0);
        FloydWarshall fw = new FloydWarshall(trainTable);
        return display(fw.shortestLoop(loc));
    }
     
    // better(?) alternative for solving 9 using Floyd Warshall
    public String fwAltShortestDistanceTripsLoop(String station){
        char loc = station.charAt(0);
        FloydWarshall fw = new FloydWarshall(trainTable);
        return display(fw.altShortestLoop(loc));
    }
    
    // solves 8 and essentially 9
    public String shortestDistanceTripsLine(String departure, String destination){
         // this is crude, but it works :: I'm open to better ways of solving this problem
         // this makes a collection hopefully (arbitraily) large enough to capture the shortest trip via dragnet...  and prob is not the most efficient method
        int aSufficientlyLargeNum = 30;
         ArrayList<Integer> distances = tripDistances(departure, destination, aSufficientlyLargeNum);
         int rtn = 1000000000; // again, set at a sufficiently high defualt b/c I don't know how to pull min out of a java array
         
         for(int path : distances){
             if (rtn > path){
                 rtn = path;
                }
            }
            return display(rtn);
        }

      // solves 9, but is essentially a wrapper for shortestDistanceTripsLine
     public String shortestDistanceTripsLoop(String station){
         return shortestDistanceTripsLine(station, station);
        }
         
    // solves 10
    public String countLoopTripsLimitDistance(String station, int limit){
         int aSufficientlyLargeNum = 30;  // set at a "sufficiently large number" of stops to try and capture the shortest path via a dragnet
         ArrayList<Integer> distances = tripDistances(station, station, aSufficientlyLargeNum);
        
         // goes over the paths, checking if they are within the limit, and increments the return
        int rtn = 0;
        for (int path : distances){
            if( path < limit) {
                rtn = rtn + 1;
            }
        }        
         return display(rtn);
        }
        
    // hopefully a more efficient alternative for solving 10    
    public String altLoopLimitDistance(String station, int limit){
        char loc = station.charAt(0);
        ArrayList<String> paths = distanceRecursiveSearch(0, limit, loc, loc, "");
        // minus 1 to the size below b/c the counts starting at the location and not moving as a "loop"
        return display(paths.size()-1);
     }
             
   // utility buffering the constructor from the nodes of the graph linked list
    private void addConnection(Station departing, char destination, int distance){
        Connection nextStop = new Connection(destination, departing.connectionList, distance);
        departing.connectionList = nextStop;
    }
             
    // utility method buffering calculateTrip from data structure
    private int calculateDistance(char origin, char destination){
        // given the origin, it looks up a station
        // it then cycles through the stations connections looking for destination
        // it then returns the connections distance, or -1 if bad data
        int rtn = -1;
        Station leavingFrom = getStation(origin);
        Connection goingTo = leavingFrom.connectionList;
        
        // guard against bad input -ie station not existing
        if(leavingFrom == null){
            return rtn;
        }
        
        // cycles through connections as long as connection exists and doesn't match destination
        while(goingTo != null && destination != goingTo.stationName){
            goingTo = goingTo.next;
        }

        // gurad against bad input -ie connection not existing
        if (goingTo == null){
            return rtn;
        }
        
        rtn = goingTo.distance;
        return rtn;
    }
    
    // another utility buffering the data structure
   private Station getStation(char location){
       for (Station loc : trainTable){
           if (loc.name == location){
               return loc;
            }
        }
        return null;
    }

    // a pseudo utility that displays data structure in console
    public void print() {
        System.out.println();
        for (Station location : trainTable){
            System.out.println(location.name);
            for(Connection con = location.connectionList; con != null; con=con.next){
                System.out.print(" --> " + con.stationName + ":" + con.distance);
            }
            System.out.println("\n");
        }          
    }
            
    // display method, outputing everything as a string
    private String display(int returnNumber){
        if(returnNumber == -1){
            return "NO SUCH ROUTE";
        } else {
            return Integer.toString(returnNumber);
        }
    }

    // a utility wrapper for solving 1-5 allowing it to be used both internally (rtn int) and exrternally (rtn String) 
    public String distanceTrip(String plan){
        return display(calculateTrip(plan));
    }
            
    // a utility for solving  8 - 10  
    private ArrayList<Integer> tripDistances(String departure, String destination, int stops){
         char from = departure.charAt(0);
         char to = destination.charAt(0);
         ArrayList<String> paths = new ArrayList<String>();
         
         for(; stops > 1; stops--){
             paths.addAll(exactLevelRecursiveSearch(0, stops, from, to, ""));
            }
            
         // this is crude, but I couldn't figure out how to reassign pointers within the original ArrayList
         // this converts each trip into its distance value
         ArrayList<Integer> secondHanoiTower = new ArrayList<Integer>();
         for(String path : paths){
             secondHanoiTower.add(calculateTrip(path));
            }            
         return secondHanoiTower;
    }

    // this is my key utility method for solving problems 6-10 :: it is a recursive f() that returns all the paths from A->B of exactly n length
    private ArrayList<String> exactLevelRecursiveSearch(int currentLevel, int finLevel, char currentLoc, char destination, String path){
        ArrayList<String> rtn = new ArrayList<String>();
        Station location = getStation(currentLoc);
        String pathTraveled;
        
        if(path == ""){
            pathTraveled = "" + currentLoc;
        } else {
            pathTraveled = path + "-" + currentLoc;
        }
        
        // base case :: if you have made the requisite # of stops and at your location, add your path to the return
        if (currentLevel == finLevel){
            if(currentLoc == destination){
                rtn.add(pathTraveled);
            }
            // recursive call :: otherwise, increment # stops by one, and recurrsive call for all connections
        } else {
            for(Connection con = location.connectionList; con != null; con=con.next){
                rtn.addAll( exactLevelRecursiveSearch(currentLevel+1, finLevel, con.stationName, destination, pathTraveled) );
            }
        }
        return rtn;
    }
    
    // alternative method for solving 10
    private ArrayList<String> distanceRecursiveSearch(int currentDistance, int finDistance, char currentLoc, char destination, String path){
        ArrayList<String> rtn = new ArrayList<String>();
        Station location = getStation(currentLoc);
        String pathTraveled;
        
        if (path == ""){
            pathTraveled = "" + currentLoc;
        } else {
            pathTraveled = path + "-" + currentLoc;
        }
        
        // base case :: only evaluate if you are less than the stop distance
        if (currentDistance < finDistance){
            // if the current path is a loop, add it to the return even if distance traveled is less than the limit
            if (currentLoc == destination){
                rtn.add(pathTraveled);
            }
            
            for(Connection con = location.connectionList; con !=null; con = con.next){
                int nextDistance = currentDistance + con.distance;
                rtn.addAll( distanceRecursiveSearch(nextDistance , finDistance, con.stationName, destination, pathTraveled));
            }
        }
        return rtn;
    }

    
    public static void main()
    throws IOException{
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter graph input file name: ");
        String file = sc.nextLine();
        FloydWTrainStudy graph = new FloydWTrainStudy(file);
        graph.print();
        System.out.println("1. Calculate path distance :: Input 'A-B-C' into calculateTrip: " + graph.calculateTrip("A-B-C"));
        System.out.println("2. Calculate path distance :: Input 'A-D' into calculateTrip: " + graph.calculateTrip("A-D"));
        System.out.println("3. Calculate path distance :: Input 'A-D-C' into calculateTrip: " + graph.calculateTrip("A-D-C"));
        System.out.println("4. Calculate path distance :: Input 'A-E-B-C-D' into calculateTrip: " + graph.calculateTrip("A-E-B-C-D"));
        System.out.println("5. Calculate path distance :: Input 'A-E-D into calculateTrip': "  + graph.calculateTrip("A-E-D"));
        System.out.println("6. Calculate # loops up to n stops :: Input 'C', 3 into countLoopTripsLimitStops: " + graph.countLoopTripsLimitStops("C", 3));
        System.out.println("7. Calculate # loops exactly to n stops :: Input 'A', 'C', 4 into countLineTripsExact: " + graph.countLineTripsExact("A", "C", 4));
        System.out.println("8. FW Calculate shortest distance A -> B :: Input 'A', 'C' into fWShortestDistanceTripsLine: " + graph.fWShortestDistanceTripsLine("A", "C"));
        System.out.println("9. alt FW Calculate shortest distance A -> A :: Input 'B' into fwAltShortestDistanceTripsLoop: " + graph.fwAltShortestDistanceTripsLoop("B"));
        System.out.println("10. alt Calculate # of loops up to n distance :: Input 'C', 30 into altLoopLimitDistance: " + graph.altLoopLimitDistance("C", 30));
        
        
    }
  }
 * 
 * 
 * 
 * 
 * 
 * */
 */
