using System;

public class aaa_readints
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
public static void stdin_sep(){
  do{
    if (eof) return;
    char c = readChar_();
    if (c == ' ' || c == '\n' || c == '\t' || c == '\r'){
      consommeChar();
    }else{
      return;
    }
  } while(true);
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
  public static int[] read_int_line(int n)
  {
    int[] tab = new int[n];
    for (int i = 0 ; i < n; i++)
    {
      int t = 0;
      t = readInt();
      stdin_sep();
      tab[i] = t;
    }
    return tab;
  }
  
  public static int[][] read_int_matrix(int x, int y)
  {
    int[][] tab = new int[y][];
    for (int z = 0 ; z < y; z++)
    {
      int[] out_ = read_int_line(x);
      stdin_sep();
      tab[z] = out_;
    }
    return tab;
  }
  
  
  public static void Main(String[] args)
  {
    int[] l0 = read_int_line(1);
    int len = l0[0];
    Console.Write(len);
    Console.Write("=len\n");
    int[] tab1 = read_int_line(len);
    for (int i = 0 ; i < len; i++)
    {
      Console.Write(i);
      Console.Write("=>");
      int a = tab1[i];
      Console.Write(a);
      Console.Write("\n");
    }
    l0 = read_int_line(1);
    len = l0[0];
    int[][] tab2 = read_int_matrix(len, len - 1);
    for (int i = 0 ; i <= len - 2; i ++)
    {
      for (int j = 0 ; j < len; j++)
      {
        int b = tab2[i][j];
        Console.Write(b);
        Console.Write(" ");
      }
      Console.Write("\n");
    }
  }
  
}

