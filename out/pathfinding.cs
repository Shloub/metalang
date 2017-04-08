using System;

public class pathfinding
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
static void stdin_sep(){
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
  static int pathfind_aux(int[][] cache, char[][] tab, int x, int y, int posX, int posY)
  {
    if (posX == x - 1 && posY == y - 1)
        return 0;
    else if (posX < 0 || posY < 0 || posX >= x || posY >= y)
        return x * y * 10;
    else if (tab[posY][posX] == (char)35)
        return x * y * 10;
    else if (cache[posY][posX] != -1)
        return cache[posY][posX];
    else
    {
        cache[posY][posX] = x * y * 10;
        int val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY);
        int val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY);
        int val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1);
        int val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1);
        int out0 = 1 + Math.Min(Math.Min(Math.Min(val1, val2), val3), val4);
        cache[posY][posX] = out0;
        return out0;
    }
  }
  
  static int pathfind(char[][] tab, int x, int y)
  {
    int[][] cache = new int[y][];
    for (int i = 0; i < y; i++)
    {
        int[] tmp = new int[x];
        for (int j = 0; j < x; j++)
            tmp[j] = -1;
        cache[i] = tmp;
    }
    return pathfind_aux(cache, tab, x, y, 0, 0);
  }
  
  public static void Main(String[] args)
  {
    int x = readInt();
    stdin_sep();
    int y = readInt();
    stdin_sep();
    char[][] tab = new char[y][];
    for (int i = 0; i < y; i++)
    {
        char[] tab2 = new char[x];
        for (int j = 0; j < x; j++)
        {
            char tmp = (char)0;
            tmp = readChar();
            tab2[j] = tmp;
        }
        stdin_sep();
        tab[i] = tab2;
    }
    int result = pathfind(tab, x, y);
    Console.Write(result);
  }
  
}

