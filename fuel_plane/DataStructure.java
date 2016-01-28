class DataStructure {
    
    Root[] rootList;
    
    /*
    public DataStructure(String[] edgeList) {
        
        for(int i=0; i < edgeList.length; i++){
            String input = 
            
        }
        
        
    }
    */
    
   public DataStructure(){
       String input = "thisIsMy1234";
       String[] test = input.split("(?=\\p{Upper} | /(\\d+)/g)");
      
       
       for(int i=0; i < test.length; i++){
          System.out.println( test[i]);
        }
       
    }
    
    
    
    
}

class Root {
    private String name;
    private Node nodes;
    
    Root(String _name){
        name = _name;
    }
    
    public String name(){
        return name;
    }
    
    public Node nodes(){
        return nodes;
    }
    
    public void setNode(Node _node){
        nodes = _node;
    }
}


class Node {
    
    private String name;
    private int weight;
    private Node next;
    
    Node(String _name, int _weight){
        name = _name;
        weight = _weight;
        next = null;
    }
    
    public String name(){
        return name;
    }
    
    public int weight(){
        return weight;
    }
    
    public Node next(){
        return next;
    }
    
    public void setNext(Node _next){
        next = _next;
    }
}