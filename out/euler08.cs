using System;

public class euler08
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
static char readChar(){
  char out_ = readChar_();
  consommeChar();
  return out_;
}
  
  
  public static void Main(String[] args)
  {
    int i = 1;
    int[] last = new int[5];
    for (int j = 0; j < 5; j++)
    {
        char c = readChar();
        int d = (int)(c) - (int)('0');
        i *= d;
        last[j] = d;
    }
    int max0 = i;
    int index = 0;
    int nskipdiv = 0;
    for (int k = 1; k < 996; k++)
    {
        char e = readChar();
        int f = (int)(e) - (int)('0');
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
            nskipdiv--;
        }
        last[index] = f;
        index = (index + 1) % 5;
        max0 = Math.Max(max0, i);
    }
    Console.Write(max0 + "\n");
  }
  
}

