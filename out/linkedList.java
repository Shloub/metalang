import java.util.*;

public class linkedList
{
  static Scanner scanner = new Scanner(System.in);
  static class intlist {public int head;public intlist tail;}
  public static intlist cons(intlist list, int i)
  {
    intlist a = new intlist();
    a.head = i;
    a.tail = list;
    intlist out_ = a;
    return out_;
  }
  
  public static intlist rev2(intlist empty, intlist acc, intlist torev)
  {
    if (torev == empty)
      return acc;
    else
    {
      intlist b = new intlist();
      b.head = torev.head;
      b.tail = acc;
      intlist acc2 = b;
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

