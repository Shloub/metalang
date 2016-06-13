package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func skip() {
  var c byte
  fmt.Fscanf(reader, "%c", &c)
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
  fmt.Printf("\n|")
  for y := 0; y <= 2; y += 1 {
      for x := 0; x <= 2; x += 1 {
          if (*g).cases[x][y] == 0 {
              fmt.Printf(" ")
          } else if (*g).cases[x][y] == 1 {
              fmt.Printf("O")
          } else {
              fmt.Printf("X")
          }
          fmt.Printf("|")
      }
      if y != 2 {
          fmt.Printf("\n|-|-|-|\n|")
      }
  }
  fmt.Printf("\n")
}

/* On dit qui gagne (info stoquées dans g.ended et g.note ) */
func eval0(g * gamestate) {
  win := 0
  freecase := 0
  for y := 0; y <= 2; y += 1 {
      col := -1
      lin := -1
      for x := 0; x <= 2; x += 1 {
          if (*g).cases[x][y] == 0 {
              freecase += 1
          }
          colv := (*g).cases[x][y]
          linv := (*g).cases[y][x]
          if col == -1 && colv != 0 {
              col = colv
          } else if colv != col {
              col = -2
          }
          if lin == -1 && linv != 0 {
              lin = linv
          } else if linv != lin {
              lin = -2
          }
      }
      if col >= 0 {
          win = col
      } else if lin >= 0 {
          win = lin
      }
  }
  for x := 1; x <= 2; x += 1 {
      if (*g).cases[0][0] == x && (*g).cases[1][1] == x && (*g).cases[2][2] == x {
          win = x
      }
      if (*g).cases[0][2] == x && (*g).cases[1][1] == x && (*g).cases[2][0] == x {
          win = x
      }
  }
  (*g).ended = win != 0 || freecase == 0
  if win == 1 {
      (*g).note = 1000
  } else if win == 2 {
      (*g).note = -1000
  } else {
      (*g).note = 0
  }
}

/* On applique un mouvement */
func apply_move_xy(x int, y int, g * gamestate) {
  player := 2
  if (*g).firstToPlay {
      player = 1
  }
  (*g).cases[x][y] = player
  (*g).firstToPlay = !(*g).firstToPlay
}

func apply_move(m * move, g * gamestate) {
  apply_move_xy((*m).x, (*m).y, g)
}

func cancel_move_xy(x int, y int, g * gamestate) {
  (*g).cases[x][y] = 0
  (*g).firstToPlay = !(*g).firstToPlay
  (*g).ended = false
}

func cancel_move(m * move, g * gamestate) {
  cancel_move_xy((*m).x, (*m).y, g)
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
  eval0(g)
  if (*g).ended {
      return (*g).note
  }
  maxNote := -10000
  if !(*g).firstToPlay {
      maxNote = 10000
  }
  for x := 0; x <= 2; x += 1 {
      for y := 0; y <= 2; y += 1 {
          if can_move_xy(x, y, g) {
              apply_move_xy(x, y, g)
              currentNote := minmax(g)
              cancel_move_xy(x, y, g)
              /* Minimum ou Maximum selon le coté ou l'on joue*/
              if currentNote > maxNote == (*g).firstToPlay {
                  maxNote = currentNote
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
      (*minMove).x=0
      (*minMove).y=0
  minNote := 10000
  for x := 0; x <= 2; x += 1 {
      for y := 0; y <= 2; y += 1 {
          if can_move_xy(x, y, g) {
              apply_move_xy(x, y, g)
              currentNote := minmax(g)
              fmt.Printf("%d, %d, %d\n", x, y, currentNote)
              cancel_move_xy(x, y, g)
              if currentNote < minNote {
                  minNote = currentNote
                  (*minMove).x = x
                  (*minMove).y = y
              }
          }
      }
  }
  fmt.Printf("%d%d\n", (*minMove).x, (*minMove).y)
  return minMove
}

func init0() * gamestate{
  var cases [][]int = make([][]int, 3)
  for i := 0; i < 3; i += 1 {
      var tab []int = make([]int, 3)
      for j := 0; j < 3; j += 1 {
          tab[j] = 0
      }
      cases[i] = tab
  }
  var a * gamestate = new (gamestate)
      (*a).cases=cases
      (*a).firstToPlay=true
      (*a).note=0
      (*a).ended=false
  return a
}

func read_move() * move{
  var y int
  var x int
  fmt.Fscanf(reader, "%d", &x)
  skip()
  fmt.Fscanf(reader, "%d", &y)
  skip()
  var b * move = new (move)
      (*b).x=x
      (*b).y=y
  return b
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  for i := 0; i <= 1; i += 1 {
      var state * gamestate = init0()
      var c * move = new (move)
          (*c).x=1
          (*c).y=1
      apply_move(c, state)
      var d * move = new (move)
          (*d).x=0
          (*d).y=0
      apply_move(d, state)
      for !(*state).ended {
          print_state(state)
          apply_move(play(state), state)
          eval0(state)
          print_state(state)
          if !(*state).ended {
              apply_move(play(state), state)
              eval0(state)
          }
      }
      print_state(state)
      fmt.Printf("%d\n", (*state).note)
  }
}

