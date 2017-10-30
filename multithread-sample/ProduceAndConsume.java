import java.text.SimpleDateFormat;
import java.util.*;

class  ProduceAndConsume{
  
    static SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
    static Object exclusion = new Object();
    static Object endProcess = new Object();
    static int requiredNumber = 1;
  
  public static class ProducerThread extends Thread
  {
      int productNumber = 1;
      boolean isComplete(){
        return (productNumber > requiredNumber);
      }
      public void run() {
        try{
          while(!isComplete())
          {
            Thread.sleep(7*1000);
            
            fifo.add (new Integer (productNumber));
            
            System.out.format("[%s] product [%d] produced\n",
                              sdf.format(Calendar.getInstance().getTime()),productNumber);
            if(fifo.size() > 0){
              synchronized(exclusion){
                exclusion.notify();
              }
            }
            productNumber++;          
          }
        }catch(Exception e){
          System.out.println(e);
        }
    }
  }
  
  public static class ConsumerThread extends Thread
  {
    ProducerThread producer = null;
    
    public ConsumerThread(ProducerThread prod){
      producer = prod;
    }

    public void run() {
      try{
        while(!(producer.isComplete() && (fifo.size() == 0))){
          Thread.sleep(10*1000);
          synchronized(exclusion){
            while(fifo.size() == 0 && !producer.isComplete()){
              exclusion.wait();
            }
            if(fifo.size() > 0)
            {
              int consume = fifo.remove();
              System.out.format("[%s] product [%d] consumed\n",
                                sdf.format(Calendar.getInstance().getTime()),consume);                    
            }
          }
        }    
    }catch(Exception e){
      System.out.println(e);
    }
   }
 }
  
  static Queue<Integer> fifo = new LinkedList<Integer>();
  
  public static void main(String argv[])
  {
    try{
          requiredNumber = Integer.parseInt(argv[0]);
    System.out.println(requiredNumber);
    
    ProducerThread prod = new ProducerThread();
    ConsumerThread consume1 = new ConsumerThread(prod);
    ConsumerThread consume2 = new ConsumerThread(prod);
    prod.start();
    consume1.start();
    consume2.start();
    prod.join();
    consume1.join();
    consume2.join();
    System.out.println("End process");
    }catch(Exception e){
      System.out.println(e);
    }

  }
}

