import java.util.*;

public class linkedList
{
  static Scanner scanner = new Scanner(System.in);
  static class intlist {public int head;public intlist tail;}
  public static intlist cons(intlist list, int i)
  {
    intlist out_ = new intlist();
    out_.head = i;
    out_.tail = list;
    return out_;
  }
  
  public static intlist rev2(intlist empty, intlist acc, intlist torev)
  {
    if (torev == empty)
      return acc;
    else
    {
      intlist acc2 = new intlist();
      acc2.head = torev.head;
      acc2.tail = acc;
      return rev2(empty, acc, torev.tail);
    }
  }
  
  public static intlist rev(intlist empty, intlist torev)
  {
    return rev2(empty, empty, torev);
  }
  
  public static void test(intlist empty)
  {
    intlist list = empty;
    int i = -1;
    while (i != 0)
    {
      if (scanner.hasNext("^-")){
      scanner.next("^-"); i = -scanner.nextInt();
      }else{
      i = scanner.nextInt();}
      if (i != 0)
        list = cons(list, i);
    }
  }
  
  
  public static void main(String args[])
  {
    
  }
  
}

