import java.util.*;

public class linkedList
{
  static Scanner scanner = new Scanner(System.in);
  static class Intlist {
    int head;
    Intlist tail;
  }
  static Intlist cons(Intlist list, int i)
  {
    Intlist out0 = new Intlist();
    out0.head = i;
    out0.tail = list;
    return out0;
  }
  
  static Intlist rev2(Intlist empty, Intlist acc, Intlist torev)
  {
    if (torev == empty)
      return acc;
    else
    {
      Intlist acc2 = new Intlist();
      acc2.head = torev.head;
      acc2.tail = acc;
      return rev2(empty, acc, torev.tail);
    }
  }
  
  static Intlist rev(Intlist empty, Intlist torev)
  {
    return rev2(empty, empty, torev);
  }
  
  static void test(Intlist empty)
  {
    Intlist list = empty;
    int i = -1;
    while (i != 0)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        i = -scanner.nextInt();
      }else{
        i = scanner.nextInt();
      }
      if (i != 0)
        list = cons(list, i);
    }
  }
  
  
  static void main(String[] args)
  {
    
  }
  
}

