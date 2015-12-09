class Airport
/**
 * The root of a linked list which will keep track of the connections for each airport
 */
{
    private String name;
    private Connection connections;
    private String origin;
    
    public Airport(String _name, Connection _connections){
        this.name = _name;
        this.connections = _connections;

    }
    
    public Airport(String _name){
        this.name = _name;
        this.connections = null;
    }
    
    public String name(){
        return name;
    }
    
    public void setConnections(Connection _connection){
        this.connections = _connection;
    }
    
    public Connection getConnections(){
        return connections;
    }
    
    public void addConnection(String destination, int fuelLoad){
        Connection newConnection = new Connection(destination, this.name, fuelLoad, this.connections);
        this.connections = newConnection;
    }
    
    public void printAirport(){
        System.out.println(name);
        if(connections != null){
            connections.printConnection();
        }
    }
}

public class TestAirport{
    public static void main(String[] args){      
        System.out.println(testName() + ": Airport name() method works?");
        System.out.println(testSetGetConnections() + ": Airport setConnections() & getConnections() methods work");
        System.out.println(testAddConnection() + ": Airport addConnection() method work");
    }
    
    static boolean testName(){
        Airport airportInstance = new Airport("Ohare", null);
        return airportInstance.name() == "Ohare";
    }
    
    static boolean testSetGetConnections(){
        Airport airportInstance = new Airport("Ohare", null);
        Connection connectionInstance = new Connection("Newark", "Philidelphia", 400);
        airportInstance.setConnections(connectionInstance);
        return airportInstance.getConnections() == connectionInstance;
    }
    
    static boolean testAddConnection(){
        Airport airportInstance = new Airport("Ohare", null);
        Connection connectionInstanceOne = new Connection("Newark","Philidelphia", 400);        
        airportInstance.setConnections(connectionInstanceOne);
        airportInstance.addConnection("London", 2000);
        
        boolean newConnectionHasName = airportInstance.getConnections().name() == "London";
        boolean newConnectionHasFuelLoad = airportInstance.getConnections().fuelLoad() == 2000;
        boolean linksOldConnectionToNewConnection = airportInstance.getConnections().next() == connectionInstanceOne;
        return newConnectionHasName && newConnectionHasFuelLoad && linksOldConnectionToNewConnection;        
    }
}