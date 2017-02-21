object tictactoe
{
  
var buffer = "";
def read_int() : Int = {
  if (buffer != null && buffer == "") buffer = readLine();
  var sign = 1;
  if (buffer != null && buffer.charAt(0) == '-'){
    sign = -1;
    buffer = buffer.substring(1);
  }
  var c = 0;
  while (buffer != null && buffer != "" && buffer.charAt(0).isDigit){
    c = c * 10 + buffer.charAt(0).asDigit;
    buffer = buffer.substring(1);
  }
  return c * sign;
}
def skip() {
  if (buffer != null && buffer == "") buffer = readLine();
  while (buffer != null && buffer != "" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\t' || buffer.charAt(0) == '\n' || buffer.charAt(0) == '\r'))
    buffer = buffer.substring(1);
}
  
  /*
Tictactoe : un tictactoe avec une IA
*/
  //  La structure de donnée 
  class Gamestate(_cases: Array[Array[Int]], _firstToPlay: Boolean, _note: Int, _ended: Boolean){
    var cases: Array[Array[Int]]=_cases;
    var firstToPlay: Boolean=_firstToPlay;
    var note: Int=_note;
    var ended: Boolean=_ended;
  }
  
  //  Un Mouvement 
  class Move(_x: Int, _y: Int){
    var x: Int=_x;
    var y: Int=_y;
  }
  
  //  On affiche l'état 
  def print_state(g : Gamestate){
    printf("\n|");
    for (y <- 0 to 2)
    {
        for (x <- 0 to 2)
        {
            if (g.cases(x)(y) == 0)
                printf(" ");
            else
                if (g.cases(x)(y) == 1)
                    printf("O");
                else
                    printf("X");
            printf("|");
        }
        if (y != 2)
            printf("\n|-|-|-|\n|");
    }
    printf("\n");
  }
  
  //  On dit qui gagne (info stoquées dans g.ended et g.note ) 
  def eval0(g : Gamestate){
    var win: Int = 0;
    var freecase: Int = 0;
    for (y <- 0 to 2)
    {
        var col: Int = -1;
        var lin: Int = -1;
        for (x <- 0 to 2)
        {
            if (g.cases(x)(y) == 0)
                freecase = freecase + 1;
            var colv: Int = g.cases(x)(y);
            var linv: Int = g.cases(y)(x);
            if (col == -1 && colv != 0)
                col = colv;
            else
                if (colv != col)
                    col = -2;
            if (lin == -1 && linv != 0)
                lin = linv;
            else
                if (linv != lin)
                    lin = -2;
        }
        if (col >= 0)
            win = col;
        else
            if (lin >= 0)
                win = lin;
    }
    for (x <- 1 to 2)
    {
        if (g.cases(0)(0) == x && g.cases(1)(1) == x && g.cases(2)(2) == x)
            win = x;
        if (g.cases(0)(2) == x && g.cases(1)(1) == x && g.cases(2)(0) == x)
            win = x;
    }
    g.ended = win != 0 || freecase == 0;
    if (win == 1)
        g.note = 1000;
    else
        if (win == 2)
            g.note = -1000;
        else
            g.note = 0;
  }
  
  //  On applique un mouvement 
  def apply_move_xy(x : Int, y : Int, g : Gamestate){
    var player: Int = 2;
    if (g.firstToPlay)
        player = 1;
    g.cases(x)(y) = player;
    g.firstToPlay = !g.firstToPlay;
  }
  
  def apply_move(m : Move, g : Gamestate){
    apply_move_xy(m.x, m.y, g);
  }
  
  def cancel_move_xy(x : Int, y : Int, g : Gamestate){
    g.cases(x)(y) = 0;
    g.firstToPlay = !g.firstToPlay;
    g.ended = false;
  }
  
  def cancel_move(m : Move, g : Gamestate){
    cancel_move_xy(m.x, m.y, g);
  }
  
  def can_move_xy(x : Int, y : Int, g : Gamestate): Boolean = {
    return g.cases(x)(y) == 0;
  }
  
  def can_move(m : Move, g : Gamestate): Boolean = {
    return can_move_xy(m.x, m.y, g);
  }
  
  /*
Un minimax classique, renvoie la note du plateau
*/
  def minmax(g : Gamestate): Int = {
    eval0(g);
    if (g.ended)
        return g.note;
    var maxNote: Int = -10000;
    if (!g.firstToPlay)
        maxNote = 10000;
    for (x <- 0 to 2)
        for (y <- 0 to 2)
            if (can_move_xy(x, y, g))
            {
                apply_move_xy(x, y, g);
                var currentNote: Int = minmax(g);
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
  def play(g : Gamestate): Move = {
    var minMove: Move = new Move(0, 0);
    var minNote: Int = 10000;
    for (x <- 0 to 2)
        for (y <- 0 to 2)
            if (can_move_xy(x, y, g))
            {
                apply_move_xy(x, y, g);
                var currentNote: Int = minmax(g);
                printf("%d, %d, %d\n", x, y, currentNote);
                cancel_move_xy(x, y, g);
                if (currentNote < minNote)
                {
                    minNote = currentNote;
                    minMove.x = x;
                    minMove.y = y;
                }
            }
    printf("%d%d\n", minMove.x, minMove.y);
    return minMove;
  }
  
  def init0(): Gamestate = {
    var cases :Array[Array[Int]] = new Array[Array[Int]](3);
    for (i <- 0 to 2)
    {
        var tab :Array[Int] = new Array[Int](3);
        for (j <- 0 to 2)
            tab(j) = 0;
        cases(i) = tab;
    }
    return new Gamestate(cases, true, 0, false);
  }
  
  def read_move(): Move = {
    var x = read_int();
    skip();
    var y = read_int();
    skip();
    return new Move(x, y);
  }
  
  
  def main(args : Array[String])
  {
    for (i <- 0 to 1)
    {
        var state: Gamestate = init0();
        apply_move(new Move(1, 1), state);
        apply_move(new Move(0, 0), state);
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
        printf("%d\n", state.note);
    }
  }
  
}

