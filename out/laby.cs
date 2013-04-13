using System;

public class laby
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



  
  public class case_state {public bool left;public bool right;public bool top;public bool bottom;public bool free;}
  public class laby {public int sizeX;public int sizeY;public case_state[][] cases;}
  public static bool can_open_right(laby state, int x, int y)
  {
    return (x < (state.sizeX - 1)) && state.cases[x + 1][y].free;
  }
  
  public static bool can_open_left(laby state, int x, int y)
  {
    return (x > 0) && state.cases[x - 1][y].free;
  }
  
  public static bool can_open_bottom(laby state, int x, int y)
  {
    return (y < (state.sizeY - 1)) && state.cases[x][y + 1].free;
  }
  
  public static bool can_open_top(laby state, int x, int y)
  {
    return (y > 0) && state.cases[x][y - 1].free;
  }
  
  public static void open_left(laby state, int x, int y)
  {
    state.cases[x - 1][y].right = false;
    state.cases[x][y].left = false;
    state.cases[x - 1][y].free = false;
    state.cases[x][y].free = false;
  }
  
  public static void open_right(laby state, int x, int y)
  {
    state.cases[x][y].right = false;
    state.cases[x + 1][y].left = false;
    state.cases[x][y].free = false;
    state.cases[x + 1][y].free = false;
  }
  
  public static void open_top(laby state, int x, int y)
  {
    state.cases[x][y - 1].bottom = false;
    state.cases[x][y].top = false;
    state.cases[x][y - 1].free = false;
    state.cases[x][y].free = false;
  }
  
  public static void open_bottom(laby state, int x, int y)
  {
    state.cases[x][y + 1].top = false;
    state.cases[x][y].bottom = false;
    state.cases[x][y + 1].free = false;
    state.cases[x][y].free = false;
  }
  
  public static laby init(int x, int y)
  {
    case_state[][] cases = new case_state[x][];
    for (int i = 0 ; i <= x - 1; i ++)
    {
      case_state[] cases_x = new case_state[y];
      for (int j = 0 ; j <= y - 1; j ++)
      {
        case_state reco = new case_state();
        reco.left = true;
        reco.right = true;
        reco.top = true;
        reco.bottom = true;
        reco.free = true;
        cases_x[j] = reco;
      }
      cases[i] = cases_x;
    }
    laby out_ = new laby();
    out_.sizeX = x;
    out_.sizeY = y;
    out_.cases = cases;
    return out_;
  }
  
  public static void print_lab(laby l)
  {
    for (int x = 0 ; x <= l.sizeX - 1; x ++)
    {
      Console.Write("__");
    }
    Console.Write("\n");
    for (int y = 0 ; y <= l.sizeY - 1; y ++)
    {
      for (int x = 0 ; x <= l.sizeX - 1; x ++)
      {
        if (l.cases[x][y].left)
        {
          if (l.cases[x][y].bottom)
          {
            Console.Write("|_");
          }
          else
          {
            Console.Write("| ");
          }
        }
        else if (l.cases[x][y].bottom)
        {
          Console.Write("__");
        }
        else
        {
          Console.Write("  ");
        }
      }
      Console.Write("|\n");
    }
    Console.Write("\n");
  }
  
  public static void gen(laby lab, int x, int y)
  {
    int e = 4;
    int[] order = new int[e];
    for (int i = 0 ; i <= e - 1; i ++)
    {
      order[i] = i;
    }
    for (int i = 0 ; i <= 2; i ++)
    {
      int j = 4 -
i;
      int k = order[i];
      order[i] = order[j];
      order[j] = k;
    }
    for (int i = 0 ; i <= 3; i ++)
    {
      if ((0 == order[i]) && can_open_left(lab, x, y))
      {
        open_left(lab, x, y);
        gen(lab, x - 1, y);
      }
      if ((1 == order[i]) && can_open_right(lab, x, y))
      {
        open_right(lab, x, y);
        gen(lab, x + 1, y);
      }
      if ((2 == order[i]) && can_open_top(lab, x, y))
      {
        open_top(lab, x, y);
        gen(lab, x, y - 1);
      }
      if ((3 == order[i]) && can_open_bottom(lab, x, y))
      {
        open_bottom(lab, x, y);
        gen(lab, x, y + 1);
      }
    }
  }
  
  
  public static void Main(String[] args)
  {
    laby lab = init(10, 10);
    gen(lab, 0, 0);
    print_lab(lab);
  }
  
}

