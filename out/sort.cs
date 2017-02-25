using System;

public class sort
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
  static int[] copytab(int[] tab, int len)
  {
    int[] o = new int[len];
    for (int i = 0; i < len; i++)
        o[i] = tab[i];
    return o;
  }
  
  static void bubblesort(int[] tab, int len)
  {
    for (int i = 0; i < len; i++)
        for (int j = i + 1; j < len; j++)
            if (tab[i] > tab[j])
            {
                int tmp = tab[i];
                tab[i] = tab[j];
                tab[j] = tmp;
            }
  }
  
  static void qsort0(int[] tab, int len, int i, int j)
  {
    if (i < j)
    {
        int i0 = i;
        int j0 = j;
        //  pivot : tab[0] 
        while (i != j)
            if (tab[i] > tab[j])
                if (i == j - 1)
                {
                    //  on inverse simplement
                    int tmp = tab[i];
                    tab[i] = tab[j];
                    tab[j] = tmp;
                    i++;
                }
                else
                {
                    //  on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] 
                    int tmp = tab[i];
                    tab[i] = tab[j];
                    tab[j] = tab[i + 1];
                    tab[i + 1] = tmp;
                    i++;
                }
            else
                j--;
        qsort0(tab, len, i0, i - 1);
        qsort0(tab, len, i + 1, j0);
    }
  }
  
  public static void Main(String[] args)
  {
    int len = 2;
    len = readInt();
    stdin_sep();
    int[] tab = new int[len];
    for (int i_ = 0; i_ < len; i_++)
    {
        int tmp = 0;
        tmp = readInt();
        stdin_sep();
        tab[i_] = tmp;
    }
    int[] tab2 = copytab(tab, len);
    bubblesort(tab2, len);
    for (int i = 0; i < len; i++)
        Console.Write(tab2[i] + " ");
    Console.Write("\n");
    int[] tab3 = copytab(tab, len);
    qsort0(tab3, len, 0, len - 1);
    for (int i = 0; i < len; i++)
        Console.Write(tab3[i] + " ");
    Console.Write("\n");
  }
  
}

