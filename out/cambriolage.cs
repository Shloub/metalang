using System;

public class cambriolage
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
  public static int max2(int a, int b)
  {
    if (a > b)
      return a;
    return b;
  }
  
  public static int nbPassePartout(int n, int[][] passepartout, int m, int[][] serrures)
  {
    int max_ancient = 0;
    int max_recent = 0;
    for (int i = 0 ; i < m; i++)
    {
      if (serrures[i][0] == -1 && serrures[i][1] > max_ancient)
        max_ancient = serrures[i][1];
      if (serrures[i][0] == 1 && serrures[i][1] > max_recent)
        max_recent = serrures[i][1];
    }
    int max_ancient_pp = 0;
    int max_recent_pp = 0;
    for (int i = 0 ; i < n; i++)
    {
      int[] pp = passepartout[i];
      if (pp[0] >= max_ancient && pp[1] >= max_recent)
        return 1;
      max_ancient_pp = max2(max_ancient_pp, pp[0]);
      max_recent_pp = max2(max_recent_pp, pp[1]);
    }
    if (max_ancient_pp >= max_ancient && max_recent_pp >= max_recent)
      return 2;
    else
      return 0;
  }
  
  
  public static void Main(String[] args)
  {
    int n = 0;
    n = readInt();
    stdin_sep();
    int[][] passepartout = new int[n][];
    for (int i = 0 ; i < n; i++)
    {
      int t = 2;
      int[] out0 = new int[t];
      for (int j = 0 ; j < t; j++)
      {
        int out_ = 0;
        out_ = readInt();
        stdin_sep();
        out0[j] = out_;
      }
      passepartout[i] = out0;
    }
    int m = 0;
    m = readInt();
    stdin_sep();
    int[][] serrures = new int[m][];
    for (int k = 0 ; k < m; k++)
    {
      int u = 2;
      int[] out1 = new int[u];
      for (int l = 0 ; l < u; l++)
      {
        int out_ = 0;
        out_ = readInt();
        stdin_sep();
        out1[l] = out_;
      }
      serrures[k] = out1;
    }
    int v = nbPassePartout(n, passepartout, m, serrures);
    Console.Write(v);
  }
  
}

