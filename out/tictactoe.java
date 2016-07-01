import java.util.*;

public class tictactoe
{
  static Scanner scanner = new Scanner(System.in);
  /*
Tictactoe : un tictactoe avec une IA
*/
  /* La structure de donnée */
  static class gamestate {
    public int[][] cases;
    public boolean firstToPlay;
    public int note;
    public boolean ended;
  }
  /* Un Mouvement */
  static class move {
    public int x;
    public int y;
  }
  /* On affiche l'état */
  static void print_state(gamestate g)
  {
    System.out.print("\n|");
    for (int y = 0; y <= 2; y += 1)
    {
        for (int x = 0; x <= 2; x += 1)
        {
            if (g.cases[x][y] == 0)
                System.out.print(" ");
            else if (g.cases[x][y] == 1)
                System.out.print("O");
            else
                System.out.print("X");
            System.out.print("|");
        }
        if (y != 2)
            System.out.print("\n|-|-|-|\n|");
    }
    System.out.print("\n");
  }
  
  /* On dit qui gagne (info stoquées dans g.ended et g.note ) */
  static void eval0(gamestate g)
  {
    int win = 0;
    int freecase = 0;
    for (int y = 0; y <= 2; y += 1)
    {
        int col = -1;
        int lin = -1;
        for (int x = 0; x <= 2; x += 1)
        {
            if (g.cases[x][y] == 0)
                freecase += 1;
            int colv = g.cases[x][y];
            int linv = g.cases[y][x];
            if (col == -1 && colv != 0)
                col = colv;
            else if (colv != col)
                col = -2;
            if (lin == -1 && linv != 0)
                lin = linv;
            else if (linv != lin)
                lin = -2;
        }
        if (col >= 0)
            win = col;
        else if (lin >= 0)
            win = lin;
    }
    for (int x = 1; x <= 2; x += 1)
    {
        if (g.cases[0][0] == x && g.cases[1][1] == x && g.cases[2][2] == x)
            win = x;
        if (g.cases[0][2] == x && g.cases[1][1] == x && g.cases[2][0] == x)
            win = x;
    }
    g.ended = win != 0 || freecase == 0;
    if (win == 1)
        g.note = 1000;
    else if (win == 2)
        g.note = -1000;
    else
        g.note = 0;
  }
  
  /* On applique un mouvement */
  static void apply_move_xy(int x, int y, gamestate g)
  {
    int player = 2;
    if (g.firstToPlay)
        player = 1;
    g.cases[x][y] = player;
    g.firstToPlay = !g.firstToPlay;
  }
  
  static void apply_move(move m, gamestate g)
  {
    apply_move_xy(m.x, m.y, g);
  }
  
  static void cancel_move_xy(int x, int y, gamestate g)
  {
    g.cases[x][y] = 0;
    g.firstToPlay = !g.firstToPlay;
    g.ended = false;
  }
  
  static void cancel_move(move m, gamestate g)
  {
    cancel_move_xy(m.x, m.y, g);
  }
  
  static boolean can_move_xy(int x, int y, gamestate g)
  {
    return g.cases[x][y] == 0;
  }
  
  static boolean can_move(move m, gamestate g)
  {
    return can_move_xy(m.x, m.y, g);
  }
  
  /*
Un minimax classique, renvoie la note du plateau
*/
  static int minmax(gamestate g)
  {
    eval0(g);
    if (g.ended)
        return g.note;
    int maxNote = -10000;
    if (!g.firstToPlay)
        maxNote = 10000;
    for (int x = 0; x <= 2; x += 1)
        for (int y = 0; y <= 2; y += 1)
            if (can_move_xy(x, y, g))
            {
                apply_move_xy(x, y, g);
                int currentNote = minmax(g);
                cancel_move_xy(x, y, g);
                /* Minimum ou Maximum selon le coté ou l'on joue*/
                if (currentNote > maxNote == g.firstToPlay)
                    maxNote = currentNote;
            }
    return maxNote;
  }
  
  /*
Renvoie le coup de l'IA
*/
  static move play(gamestate g)
  {
    move minMove = new move();
    minMove.x = 0;
    minMove.y = 0;
    int minNote = 10000;
    for (int x = 0; x <= 2; x += 1)
        for (int y = 0; y <= 2; y += 1)
            if (can_move_xy(x, y, g))
            {
                apply_move_xy(x, y, g);
                int currentNote = minmax(g);
                System.out.printf("%d, %d, %d\n", x, y, currentNote);
                cancel_move_xy(x, y, g);
                if (currentNote < minNote)
                {
                    minNote = currentNote;
                    minMove.x = x;
                    minMove.y = y;
                }
            }
    System.out.printf("%d%d\n", minMove.x, minMove.y);
    return minMove;
  }
  
  static gamestate init0()
  {
    int[][] cases = new int[3][];
    for (int i = 0; i < 3; i += 1)
    {
        int[] tab = new int[3];
        for (int j = 0; j < 3; j += 1)
            tab[j] = 0;
        cases[i] = tab;
    }
    gamestate a = new gamestate();
    a.cases = cases;
    a.firstToPlay = true;
    a.note = 0;
    a.ended = false;
    return a;
  }
  
  static move read_move()
  {
    int x;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      x = scanner.nextInt();
    } else {
      x = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int y;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      y = scanner.nextInt();
    } else {
      y = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    move b = new move();
    b.x = x;
    b.y = y;
    return b;
  }
  
  
  public static void main(String args[])
  {
    for (int i = 0; i <= 1; i += 1)
    {
        gamestate state = init0();
        move c = new move();
        c.x = 1;
        c.y = 1;
        apply_move(c, state);
        move d = new move();
        d.x = 0;
        d.y = 0;
        apply_move(d, state);
        while (!state.ended)
        {
            print_state(state);
            apply_move(play(state), state);
            eval0(state);
            print_state(state);
            if (!state.ended)
            {
                apply_move(play(state), state);
                eval0(state);
            }
        }
        print_state(state);
        System.out.printf("%d\n", state.note);
    }
  }
  
}

