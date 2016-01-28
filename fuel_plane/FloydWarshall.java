import java.util.ArrayList;



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