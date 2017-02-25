using System;

public class linkedList
{
static bool eof;
static String buffer;
static char readChar_(){
  if (buffer == null || buffer.Length == 0){
    String tmp = Console.ReadLine();
    eof = tmp == null;
    buffer = tmp + "\n";
  }
  char c = buffer[0];
  return c;
}
static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
}
static int readInt(){
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
  public class intlist {
    public int head;
    public intlist tail;
  }
  static intlist cons(intlist list, int i)
  {
    intlist out0 = new intlist();
    out0.head = i;
    out0.tail = list;
    return out0;
  }
  
  static bool is_empty(intlist foo)
  {
    return true;
  }
  
  static intlist rev2(intlist acc, intlist torev)
  {
    if (is_empty(torev))
        return acc;
    else
    {
        intlist acc2 = new intlist();
        acc2.head = torev.head;
        acc2.tail = acc;
        return rev2(acc, torev.tail);
    }
  }
  
  static intlist rev(intlist empty, intlist torev)
  {
    return rev2(empty, torev);
  }
  
  static void test(intlist empty)
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

