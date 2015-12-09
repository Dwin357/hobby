
/**
 * Write a description of class Test here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Test
{
    private TestObj tObj = new TestObj();
    /**
     * Constructor for objects of class Test
     */
    public Test()
    {
        // initialise instance variables

        String test = "123";
        int[] ary = {1,2,3};
        //System.out.println(Integer.parseInt(test.substring(0, 1)));
        //tObj.theMan();
        System.out.println(ary.length);
    }
}

class TestObj{
    public void theMan(){
           System.out.println("from inside the test object");
    }
}
