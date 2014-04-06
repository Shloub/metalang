using System;

public class euler08
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
public static char readChar(){
  char out_ = readChar_();
  consommeChar();
  return out_;
}
  
  public static int max2(int a, int b)
  {
    if (a > b)
      return a;
    return b;
  }
  
  
  public static void Main(String[] args)
  {
    int i = 1;
    int g = 5;
    int[] last = new int[g];
    for (int j = 0 ; j < g; j++)
    {
      char c = '_';
      c = readChar();
      int d = c - '0';
      i *= d;
      last[j] = d;
    }
    int max_ = i;
    int index = 0;
    int nskipdiv = 0;
    for (int k = 1 ; k <= 995; k ++)
    {
      char e = '_';
      e = readChar();
      int f = e - '0';
      if (f == 0)
      {
        i = 1;
        nskipdiv = 4;
      }
      else
      {
        i *= f;
        if (nskipdiv < 0)
          i /= last[index];
        nskipdiv --;
      }
      last[index] = f;
      index = (index + 1) % 5;
      max_ = max2(max_, i);
    }
    Console.Write(max_);
    Console.Write("\n");
  }
  
}

