using System;

public class tictactoe
{
  /*
Tictactoe : un tictactoe avec une IA
*/
  /* La structure de donnée */
  public class gamestate {public int[][] cases;public bool firstToPlay;public int note;public bool ended;}
  /* Un Mouvement */
  public class move {public int x;public int y;}
  /* On affiche l'état */
  public static void print_state(gamestate g)
  {
    Console.Write("\n|");
    for (int y = 0 ; y <= 2; y ++)
    {
      for (int x = 0 ; x <= 2; x ++)
      {
        if (g.cases[x][y] == 0)
        {
          Console.Write(" ");
        }
        else if (g.cases[x][y] == 1)
        {
          Console.Write("O");
        }
        else
        {
          Console.Write("X");
        }
        Console.Write("|");
      }
      if (y != 2)
      {
        Console.Write("\n|-|-|-|\n|");
      }
    }
    Console.Write("\n");
  }
  
  /* On dit qui gagne (info stoquées dans g.ended et g.note ) */
  public static void eval_(gamestate g)
  {
    int win = 0;
    int freecase = 0;
    for (int y = 0 ; y <= 2; y ++)
    {
      int col = -1;
      int lin = -1;
      for (int x = 0 ; x <= 2; x ++)
      {
        if (g.cases[x][y] == 0)
        {
          freecase = freecase + 1;
        }
        int colv = g.cases[x][y];
        int linv = g.cases[y][x];
        if ((col == -1) && (colv != 0))
        {
          col = colv;
        }
        else if (colv != col)
        {
          col = -2;
        }
        if ((lin == -1) && (linv != 0))
        {
          lin = linv;
        }
        else if (linv != lin)
        {
          lin = -2;
        }
      }
      if (col >= 0)
      {
        win = col;
      }
      else if (lin >= 0)
      {
        win = lin;
      }
    }
    for (int x = 1 ; x <= 2; x ++)
    {
      if (((g.cases[0][0] == x) && (g.cases[1][1] == x)) && (g.cases[2][2] == x))
      {
        win = x;
      }
      if (((g.cases[0][2] == x) && (g.cases[1][1] == x)) && (g.cases[2][0] == x))
      {
        win = x;
      }
    }
    g.ended = (win != 0) || (freecase == 0);
    if (win == 1)
    {
      g.note = 1000;
    }
    else if (win == 2)
    {
      g.note = -1000;
    }
    else
    {
      g.note = 0;
    }
  }
  
  /* On applique un mouvement */
  public static void apply_move_xy(int x, int y, gamestate g)
  {
    int player = 2;
    if (g.firstToPlay)
    {
      player = 1;
    }
    g.cases[x][y] = player;
    g.firstToPlay = !g.firstToPlay;
  }
  
  public static void apply_move(move m, gamestate g)
  {
    apply_move_xy(m.x, m.y, g);
  }
  
  public static void cancel_move_xy(int x, int y, gamestate g)
  {
    g.cases[x][y] = 0;
    g.firstToPlay = !g.firstToPlay;
    g.ended = false;
  }
  
  public static bool can_move_xy(int x, int y, gamestate g)
  {
    return g.cases[x][y] == 0;
  }
  
  public static int minmax(gamestate g)
  {
    eval_(g);
    if (g.ended)
    {
      return g.note;
    }
    int maxNote = -10000;
    if (!g.firstToPlay)
    {
      maxNote = 10000;
    }
    for (int x = 0 ; x <= 2; x ++)
    {
      for (int y = 0 ; y <= 2; y ++)
      {
        if (can_move_xy(x, y, g))
        {
          apply_move_xy(x, y, g);
          int currentNote = minmax(g);
          cancel_move_xy(x, y, g);
          if ((currentNote > maxNote) == g.firstToPlay)
          {
            maxNote = currentNote;
          }
        }
      }
    }
    return maxNote;
  }
  
  public static move play(gamestate g)
  {
    move minMove = new move();
    minMove.x = 0;
    minMove.y = 0;
    int minNote = 10000;
    for (int x = 0 ; x <= 2; x ++)
    {
      for (int y = 0 ; y <= 2; y ++)
      {
        if (can_move_xy(x, y, g))
        {
          apply_move_xy(x, y, g);
          int currentNote = minmax(g);
          Console.Write(x);
          Console.Write(", ");
          Console.Write(y);
          Console.Write(", ");
          Console.Write(currentNote);
          Console.Write("\n");
          cancel_move_xy(x, y, g);
          if (currentNote < minNote)
          {
            minNote = currentNote;
            minMove.x = x;
            minMove.y = y;
          }
        }
      }
    }
    int u = minMove.x;
    Console.Write(u);
    int v = minMove.y;
    Console.Write(v);
    Console.Write("\n");
    return minMove;
  }
  
  public static gamestate init()
  {
    int z = 3;
    int[][] cases = new int[z][];
    for (int i = 0 ; i < z; i++)
    {
      int w = 3;
      int[] tab = new int[w];
      for (int j = 0 ; j < w; j++)
      {
        tab[j] = 0;
      }
      cases[i] = tab;
    }
    gamestate out_ = new gamestate();
    out_.cases = cases;
    out_.firstToPlay = true;
    out_.note = 0;
    out_.ended = false;
    return out_;
  }
  
  
  public static void Main(String[] args)
  {
    for (int i = 0 ; i <= 1; i ++)
    {
      gamestate state = init();
      while (!state.ended)
      {
        print_state(state);
        apply_move(play(state), state);
        eval_(state);
        print_state(state);
        if (!state.ended)
        {
          apply_move(play(state), state);
          eval_(state);
        }
      }
      print_state(state);
      int ba = state.note;
      Console.Write(ba);
      Console.Write("\n");
    }
  }
  
}

