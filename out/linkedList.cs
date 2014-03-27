using System;

public class linkedList
{
static bool eof;
static String buffer;
public static char readChar_(){
  if (buffer == null){
    buffer = Console.ReadLine();
  }
  if (buffer.Length == 0){
    String tmp = Console.ReadLine();
    eof = tmp == null;
    buffer = "\n"+tmp;
  }
  char c = buffer[0];
  return c;
}
public static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
}
public static int readInt(){
  int i = 0;
  char s = readChar_();
  int sign = 1;
  if (s == '-'){
    sign = -1;
    consommeChar();
  }
  do{
    char c = readChar_();
    if (c <= '9' && c >= '0'){
      i = i * 10 + c - '0';
      consommeChar();
    }else{
      return i * sign;
    }
  } while(true);
} 
  public class intlist {public int head;public intlist tail;}
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
      i = readInt();
      if (i != 0)
        list = cons(list, i);
    }
  }
  
  
  public static void Main(String[] args)
  {
    
  }
  
}

