#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
/*
Tictactoe : un tictactoe avec une IA
*/
/* La structure de donnée */
class gamestate {
public:
  std::vector<std::vector<int > > cases;
  bool firstToPlay;
  int note;
  bool ended;
};

/* Un Mouvement */
class move {
public:
  int x;
  int y;
};

/* On affiche l'état */
void print_state(gamestate * g){
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
void eval_(gamestate * g){
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
void apply_move_xy(int x, int y, gamestate * g){
  int player = 2;
  if (g->firstToPlay)
    player = 1;
  g->cases.at(x).at(y) = player;
  g->firstToPlay = !g->firstToPlay;
}

void apply_move(move * m, gamestate * g){
  apply_move_xy(m->x, m->y, g);
}

void cancel_move_xy(int x, int y, gamestate * g){
  g->cases.at(x).at(y) = 0;
  g->firstToPlay = !g->firstToPlay;
  g->ended = false;
}

void cancel_move(move * m, gamestate * g){
  cancel_move_xy(m->x, m->y, g);
}

bool can_move_xy(int x, int y, gamestate * g){
  return g->cases.at(x).at(y) == 0;
}

bool can_move(move * m, gamestate * g){
  return can_move_xy(m->x, m->y, g);
}

/*
Un minimax classique, renvoie la note du plateau
*/
int minmax(gamestate * g){
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
move * play(gamestate * g){
  move * minMove = new move();
  minMove->x=0;
  minMove->y=0;
  int minNote = 10000;
  for (int x = 0 ; x <= 2; x ++)
    for (int y = 0 ; y <= 2; y ++)
      if (can_move_xy(x, y, g))
  {
    apply_move_xy(x, y, g);
    int currentNote = minmax(g);
    std::cout << x << ", " << y << ", " << currentNote << "\n";
    cancel_move_xy(x, y, g);
    if (currentNote < minNote)
    {
      minNote = currentNote;
      minMove->x = x;
      minMove->y = y;
    }
  }
  int a = minMove->x;
  std::cout << a;
  int b = minMove->y;
  std::cout << b << "\n";
  return minMove;
}

gamestate * init_(){
  int d = 3;
  std::vector<std::vector<int > > cases( d );
  for (int i = 0 ; i < d; i++)
  {
    int c = 3;
    std::vector<int > tab( c );
    for (int j = 0 ; j < c; j++)
      tab.at(j) = 0;
    cases.at(i) = tab;
  }
  gamestate * f = new gamestate();
  f->cases=cases;
  f->firstToPlay=true;
  f->note=0;
  f->ended=false;
  return f;
}

move * read_move(){
  int x = 0;
  std::cin >> x >> std::skipws;
  int y = 0;
  std::cin >> y >> std::skipws;
  move * h = new move();
  h->x=x;
  h->y=y;
  return h;
}


int main(){
  for (int i = 0 ; i <= 1; i ++)
  {
    gamestate * state = init_();
    move * k = new move();
    k->x=1;
    k->y=1;
    apply_move(k, state);
    move * l = new move();
    l->x=0;
    l->y=0;
    apply_move(l, state);
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
    int e = state->note;
    std::cout << e << "\n";
  }
  return 0;
}

