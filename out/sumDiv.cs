using System;

public class sumDiv
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
  static void foo()
  {
    int a = 0;
    //  test 
    
    a++;
    //  test 2 
    
  }
  
  static void foo2()
  {
    
  }
  
  static void foo3()
  {
    if (1 == 1)
    {
        
    }
  }
  
  static int sumdiv(int n)
  {
    //  On désire renvoyer la somme des diviseurs 
    
    int out0 = 0;
    //  On déclare un entier qui contiendra la somme 
    
    for (int i = 1; i <= n; i++)
        //  La boucle : i est le diviseur potentiel
        
        if (n % i == 0)
        {
            //  Si i divise 
            
            out0 += i;
            //  On incrémente 
            
        }
        else
        {
            //  nop 
            
        }
    return out0;
    // On renvoie out
    
  }
  
  
  public static void Main(String[] args)
  {
    //  Programme principal 
    
    int n = 0;
    n = readInt();
    //  Lecture de l'entier 
    
    Console.Write(sumdiv(n));
  }
  
}

