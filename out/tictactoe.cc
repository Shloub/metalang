#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
/*
Tictactoe : un tictactoe avec une IA
*/
/* La structure de donnée */
struct gamestate;
typedef struct gamestate {
  std::vector<std::vector<int > > cases;
  bool firstToPlay;
  int note;
  bool ended;
} gamestate;

/* Un Mouvement */
struct move;
typedef struct move {
  int x;
  int y;
} move;

/* On affiche l'état */
void print_state(struct gamestate * g){
  std::cout << "\n|";
  for (int y = 0 ; y <= 2; y ++)
  {
    for (int x = 0 ; x <= 2; x ++)
    {
      if (g->cases.at(x).at(y) == 0)
        std::cout << " ";
      else if (g->cases.at(x).at(y) == 1)
        std::cout << "O";
      else
        std::cout << "X";
      std::cout << "|";
    }
    if (y != 2)
      std::cout << "\n|-|-|-|\n|";
  }
  std::cout << "\n";
}

/* On dit qui gagne (info stoquées dans g.ended et g.note ) */
void eval_(struct gamestate * g){
  int win = 0;
  int freecase = 0;
  for (int y = 0 ; y <= 2; y ++)
  {
    int col = -1;
    int lin = -1;
    for (int x = 0 ; x <= 2; x ++)
    {
      if (g->cases.at(x).at(y) == 0)
        freecase ++;
      int colv = g->cases.at(x).at(y);
      int linv = g->cases.at(y).at(x);
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
  for (int x = 1 ; x <= 2; x ++)
  {
    if (g->cases.at(0).at(0) == x && g->cases.at(1).at(1) == x && g->cases.at(2).at(2) == x)
      win = x;
    if (g->cases.at(0).at(2) == x && g->cases.at(1).at(1) == x && g->cases.at(2).at(0) == x)
      win = x;
  }
  g->ended = win != 0 || freecase == 0;
  if (win == 1)
    g->note = 1000;
  else if (win == 2)
    g->note = -1000;
  else
    g->note = 0;
}

/* On applique un mouvement */
void apply_move_xy(int x, int y, struct gamestate * g){
  int player = 2;
  if (g->firstToPlay)
    player = 1;
  g->cases.at(x).at(y) = player;
  g->firstToPlay = !g->firstToPlay;
}

void apply_move(struct move * m, struct gamestate * g){
  apply_move_xy(m->x, m->y, g);
}

void cancel_move_xy(int x, int y, struct gamestate * g){
  g->cases.at(x).at(y) = 0;
  g->firstToPlay = !g->firstToPlay;
  g->ended = false;
}

bool can_move_xy(int x, int y, struct gamestate * g){
  return g->cases.at(x).at(y) == 0;
}

/*
Un minimax classique, renvoie la note du plateau
*/
int minmax(struct gamestate * g){
  eval_(g);
  if (g->ended)
    return g->note;
  int maxNote = -10000;
  if (!g->firstToPlay)
    maxNote = 10000;
  for (int x = 0 ; x <= 2; x ++)
    for (int y = 0 ; y <= 2; y ++)
      if (can_move_xy(x, y, g))
  {
    apply_move_xy(x, y, g);
    int currentNote = minmax(g);
    cancel_move_xy(x, y, g);
    /* Minimum ou Maximum selon le coté ou l'on joue*/
    if ((currentNote > maxNote) == g->firstToPlay)
      maxNote = currentNote;
  }
  return maxNote;
}

/*
Renvoie le coup de l'IA
*/
struct move * play(struct gamestate * g){
  struct move * minMove = new move();
  minMove->x=0;
  minMove->y=0;
  int minNote = 10000;
  for (int x = 0 ; x <= 2; x ++)
    for (int y = 0 ; y <= 2; y ++)
      if (can_move_xy(x, y, g))
  {
    apply_move_xy(x, y, g);
    int currentNote = minmax(g);
    printf("%d", x);
    std::cout << ", ";
    printf("%d", y);
    std::cout << ", ";
    printf("%d", currentNote);
    std::cout << "\n";
    cancel_move_xy(x, y, g);
    if (currentNote < minNote)
    {
      minNote = currentNote;
      minMove->x = x;
      minMove->y = y;
    }
  }
  int p = minMove->x;
  printf("%d", p);
  int q = minMove->y;
  printf("%d", q);
  std::cout << "\n";
  return minMove;
}

struct gamestate * init(){
  int s = 3;
  std::vector<std::vector<int > > cases( s );
  for (int i = 0 ; i < s; i++)
  {
    int r = 3;
    std::vector<int > tab( r );
    for (int j = 0 ; j < r; j++)
      tab.at(j) = 0;
    cases.at(i) = tab;
  }
  struct gamestate * out_ = new gamestate();
  out_->cases=cases;
  out_->firstToPlay=true;
  out_->note=0;
  out_->ended=false;
  return out_;
}


int main(void){
  for (int i = 0 ; i <= 1; i ++)
  {
    struct gamestate * state = init();
    while (!state->ended)
    {
      print_state(state);
      apply_move(play(state), state);
      eval_(state);
      print_state(state);
      if (!state->ended)
      {
        apply_move(play(state), state);
        eval_(state);
      }
    }
    print_state(state);
    int t = state->note;
    printf("%d", t);
    std::cout << "\n";
  }
  return 0;
}

