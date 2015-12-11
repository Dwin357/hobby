import java.util.ArrayList;

public class FloydWarshallOptimizedConnections
{
    String[] airportNames;
    int [][] optimizedFuelLimits;
    int infinite = 999999;
    
    FloydWarshallOptimizedConnections(ArrayList<Airport> flightRoutes){
        setNodeNames(flightRoutes);
        setEdgeWeights(flightRoutes);
        optimizeConnections();
    }
    
    public int mostEfficientLinearFlight(String origin, String destination){
        return optimizedFuelLimits[getIndexOf(origin)][getIndexOf(destination)];
    }
    
    public int mostEfficientRoundTrip(String origin){
        return mostEfficientLinearFlight(origin, origin);
    }
    
    private void setNodeNames(ArrayList<Airport> flightRoutes){
        airportNames = new String[flightRoutes.size()];
        int i = 0;
        for (Airport airport : flightRoutes){
            airportNames[i] = airport.name();
            i = i +1;
        }
    }
    
    private void setEdgeWeights(ArrayList<Airport> flightRoutes){
        optimizedFuelLimits = new int[flightRoutes.size()][flightRoutes.size()];
        for (Airport origin : flightRoutes){
            int i = getIndexOf(origin);
            
            for(int j=0; j < flightRoutes.size(); j++){
                String destination = airportNames[j];
                
                if(i == j){
                    optimizedFuelLimits[i][j] = 0;
                } else if (hasConnection(origin, destination)){
                    optimizedFuelLimits[i][j] = edgeWeight(origin, destination);
                } else {
                    optimizedFuelLimits[i][j] = infinite;
                }
            }
        }
    }
    
    private int edgeWeight(Airport origin, String destination){
        for (Connection con = origin.getConnections(); con !=null; con = con.next()){
            if(con.name().equals(destination)){
                return con.fuelLoad();
            }
        }
        return -1;
    }
    
    private boolean hasConnection(Airport origin, String destination){
        for (Connection con = origin.getConnections(); con !=null; con = con.next()){
            if(con.name().equals(destination)){
                return true;
            }
        }
        return false;
    }
    
    private int getIndexOf(String airportName){
        for(int i=0; i < airportNames.length; i++){
            if (airportNames[i].equals(airportName)){
                return i;
            }
        }
        return -1;
    }
    
    private int getIndexOf(Airport airport){
        return getIndexOf(airport.name());
    }
    
    private void optimizeConnections(){
        // this gets around the normal limitation of the FW of not being able to calculate loops
        // by first optimizing all non-loop paths, then resetting loops to infinite and running
        // the algorythum again.  My other idea for doing this was, for each loop position, to 
        // test the "there + back" edgeWeights for every other position and select the lowest
        floydWarshallAlgorythm();
        resetLoopsToInfinite();
        floydWarshallAlgorythm();
    }
    
    private void resetLoopsToInfinite(){        
        for(int i=0; i < airportNames.length; i++){
            optimizedFuelLimits[i][i] = infinite;
        }
    }
    
    private void floydWarshallAlgorythm(){
        for(int i=0; i< airportNames.length; i++){
            for(int j=0; j < airportNames.length; j++){
                for(int k=0; k < airportNames.length; k++){
                    if(optimizedFuelLimits[i][j] > optimizedFuelLimits[i][k] + optimizedFuelLimits[k][j]){
                        optimizedFuelLimits[i][j] = optimizedFuelLimits[i][k] + optimizedFuelLimits[k][j];
                    }
                }
            }
        }
    }
}
