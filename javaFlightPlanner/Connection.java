class Connection
/**
 * The node of a linked list which will keep track of the connections for each airport
 */
{
    private String name;
    private String origin;
    private int fuelLoad;
    private Connection nextConnection;
    
    public Connection(String _name, String _origin, int _fuelLoad, Connection _nextConnection){
        this.name = _name;
        this.origin = _origin;
        this.fuelLoad = _fuelLoad;
        this.nextConnection = _nextConnection;
    }
    
    public Connection(String _name, String _origin, int _fuelLoad){
        this.name = _name;
        this.origin = _origin;
        this.fuelLoad = _fuelLoad;
        this.nextConnection = null;
    }
    
    public String name(){
        return name;
    }
    
    public String origin(){
        return origin;
    }
    
    public int fuelLoad(){
        return fuelLoad;
    }
    
    public void setNext(Connection _connection){
        nextConnection = _connection;
    }
    
    public Connection next(){
        return nextConnection;
    }      
    
    public void printConnection(){
        System.out.print("--> " + name + ":" + fuelLoad);
        if (nextConnection != null){
            nextConnection.printConnection();
        }
    }
    
    public static void test(){
        new TestConnection();
    }
}

class ConnectionTester{
    public static void main(String[] args){
        System.out.println(testName() + ": Connection name() works");
        System.out.println(testOrigin() + ": Connection origin() works");
        System.out.println(testFuelLoad() + ": Connection fuelLoad() works");
        System.out.println(testNext() + ": Connection next() works");
        System.out.println(testSetNext() + ": Connection setNext() works");
    }
    
    private void stringsEqual (String actual, String expected){
        if (!actual.equals(expected)){
            String message = String.format("Failure: expected '%s', got '%s'", expected, actual);
            throw new RuntimeException(message);
        }
    }
    
    static boolean testName(){
        Connection connection = new Connection("Joliet", "Ohare", 25);
        return connection.name() == "Joliet";
    }
    
    static boolean testOrigin(){
        Connection connection = new Connection("Joliet", "Ohare", 25);
        return connection.origin() == "Ohare";
    }
    
    static boolean testFuelLoad(){
        Connection connection = new Connection("Joliet", "Ohare", 25);
        return connection.fuelLoad() == 25;
    }
    
    static boolean testNext(){
        Connection connection = new Connection("Joliet", "Ohare", 25);
        Connection testCase = new Connection("Rockford", "Phoneix", 60, connection);
        return testCase.next() == connection;
    }
    
    static boolean testSetNext(){
        Connection theNext = new Connection("Joliet", "Ohare", 25);
        Connection testCase = new Connection("Rockford", "Phoneix", 60);
        testCase.setNext(theNext);
        return testCase.next() == theNext;
    }
}