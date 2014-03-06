package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func skip() {
  var c byte
  fmt.Fscanf(reader, "%c", &c);
  if c == '\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}


/*
Tictactoe : un tictactoe avec une IA
*/
/* La structure de donnée */

type gamestate struct {
  cases [][]int;
  firstToPlay bool;
  note int;
  ended bool;
}

/* Un Mouvement */

type move struct {
  x int;
  y int;
}

/* On affiche l'état */
func print_state(g * gamestate) {
  fmt.Printf("\n|");
  for y := 0 ; y <= 2; y++ {
    for x := 0 ; x <= 2; x++ {
        if (*g).cases[x][y] == 0 {
            fmt.Printf(" ");
          } else if (*g).cases[x][y] == 1 {
            fmt.Printf("O");
          } else {
            fmt.Printf("X");
          } 
          fmt.Printf("|");
      }
      if y != 2 {
        fmt.Printf("\n|-|-|-|\n|");
      }
  }
  fmt.Printf("\n");
}

/* On dit qui gagne (info stoquées dans g.ended et g.note ) */
func eval_(g * gamestate) {
  var win int = 0
  var freecase int = 0
  for y := 0 ; y <= 2; y++ {
    var col int = -1
      var lin int = -1
      for x := 0 ; x <= 2; x++ {
        if (*g).cases[x][y] == 0 {
            freecase ++;
          }
          var colv int = (*g).cases[x][y]
          var linv int = (*g).cases[y][x]
          if col == -1 && colv != 0 {
            col = colv;
          } else if colv != col {
            col = -2;
          } 
          if lin == -1 && linv != 0 {
            lin = linv;
          } else if linv != lin {
            lin = -2;
          } 
      }
      if col >= 0 {
        win = col;
      } else if lin >= 0 {
        win = lin;
      } 
  }
  for x := 1 ; x <= 2; x++ {
    if (*g).cases[0][0] == x && (*g).cases[1][1] == x && (*g).cases[2][2] == x {
        win = x;
      }
      if (*g).cases[0][2] == x && (*g).cases[1][1] == x && (*g).cases[2][0] == x {
        win = x;
      }
  }
  (*g).ended = win != 0 || freecase == 0;
  if win == 1 {
    (*g).note = 1000;
  } else if win == 2 {
    (*g).note = -1000;
  } else {
    (*g).note = 0;
  } 
}

/* On applique un mouvement */
func apply_move_xy(x int, y int, g * gamestate) {
  var player int = 2
  if (*g).firstToPlay {
    player = 1;
  }
  (*g).cases[x][y] = player;
  (*g).firstToPlay = !(*g).firstToPlay;
}

func apply_move(m * move, g * gamestate) {
  apply_move_xy((*m).x, (*m).y, g);
}

func cancel_move_xy(x int, y int, g * gamestate) {
  (*g).cases[x][y] = 0;
  (*g).firstToPlay = !(*g).firstToPlay;
  (*g).ended = false;
}

func cancel_move(m * move, g * gamestate) {
  cancel_move_xy((*m).x, (*m).y, g);
}

func can_move_xy(x int, y int, g * gamestate) bool{
  return (*g).cases[x][y] == 0
}

func can_move(m * move, g * gamestate) bool{
  return can_move_xy((*m).x, (*m).y, g)
}

/*
Un minimax classique, renvoie la note du plateau
*/
func minmax(g * gamestate) int{
  eval_(g);
  if (*g).ended {
    return (*g).note
  }
  var maxNote int = -10000
  if !(*g).firstToPlay {
    maxNote = 10000;
  }
  for x := 0 ; x <= 2; x++ {
    for y := 0 ; y <= 2; y++ {
        if can_move_xy(x, y, g) {
            apply_move_xy(x, y, g);
              var currentNote int = minmax(g)
              cancel_move_xy(x, y, g);
              /* Minimum ou Maximum selon le coté ou l'on joue*/
              if (currentNote > maxNote) == (*g).firstToPlay {
                maxNote = currentNote;
              }
          }
      }
  }
  return maxNote
}

/*
Renvoie le coup de l'IA
*/
func play(g * gamestate) * move{
  var minMove * move = new (move)
  (*minMove).x=0;
  (*minMove).y=0;
  var minNote int = 10000
  for x := 0 ; x <= 2; x++ {
    for y := 0 ; y <= 2; y++ {
        if can_move_xy(x, y, g) {
            apply_move_xy(x, y, g);
              var currentNote int = minmax(g)
              fmt.Printf("%d, %d, %d\n", x, y, currentNote);
              cancel_move_xy(x, y, g);
              if currentNote < minNote {
                minNote = currentNote;
                  (*minMove).x = x;
                  (*minMove).y = y;
              }
          }
      }
  }
  var a int = (*minMove).x
  fmt.Printf("%d", a);
  var b int = (*minMove).y
  fmt.Printf("%d\n", b);
  return minMove
}

func init_() * gamestate{
  var d int = 3
  var cases [][]int = make([][]int, d)
  for i := 0 ; i <= d - 1; i++ {
    var c int = 3
      var tab []int = make([]int, c)
      for j := 0 ; j <= c - 1; j++ {
        tab[j] = 0;
      }
      cases[i] = tab;
  }
  var out_ * gamestate = new (gamestate)
  (*out_).cases=cases;
  (*out_).firstToPlay=true;
  (*out_).note=0;
  (*out_).ended=false;
  return out_
}

func read_move() * move{
  var x int = 0
  fmt.Fscanf(reader, "%d", &x);
  skip()
  var y int = 0
  fmt.Fscanf(reader, "%d", &y);
  skip()
  var out_ * move = new (move)
  (*out_).x=x;
  (*out_).y=y;
  return out_
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  for i := 0 ; i <= 1; i++ {
    var state * gamestate = init_()
      for !(*state).ended{
                           print_state(state);
                           apply_move(play(state), state);
                           eval_(state);
                           print_state(state);
                           if !(*state).ended {
                             apply_move(play(state), state);
                               eval_(state);
                           }
      }
      print_state(state);
      var e int = (*state).note
      fmt.Printf("%d\n", e);
  }
}

