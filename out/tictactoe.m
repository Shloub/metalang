#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

/*
Tictactoe : un tictactoe avec une IA
*/
/* La structure de donnée */
@interface gamestate : NSObject
{
  @public int** cases;
  @public int firstToPlay;
  @public int note;
  @public int ended;
}
@end
@implementation gamestate 
@end

/* Un Mouvement */
@interface move : NSObject
{
  @public int x;
  @public int y;
}
@end
@implementation move 
@end

/* On affiche l'état */
void print_state(gamestate * g){
  int y, x;
  printf("\n|");
  for (y = 0 ; y <= 2; y++)
  {
    for (x = 0 ; x <= 2; x++)
    {
      if (g->cases[x][y] == 0)
        printf(" ");
      else if (g->cases[x][y] == 1)
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

/* On dit qui gagne (info stoquées dans g.ended et g.note ) */
void eval_(gamestate * g){
  int y, x;
  int win = 0;
  int freecase = 0;
  for (y = 0 ; y <= 2; y++)
  {
    int col = -1;
    int lin = -1;
    for (x = 0 ; x <= 2; x++)
    {
      if (g->cases[x][y] == 0)
        freecase ++;
      int colv = g->cases[x][y];
      int linv = g->cases[y][x];
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
  for (x = 1 ; x <= 2; x++)
  {
    if (g->cases[0][0] == x && g->cases[1][1] == x && g->cases[2][2] == x)
      win = x;
    if (g->cases[0][2] == x && g->cases[1][1] == x && g->cases[2][0] == x)
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
  g->cases[x][y] = player;
  g->firstToPlay = !g->firstToPlay;
}

void apply_move(move * m, gamestate * g){
  apply_move_xy(m->x, m->y, g);
}

void cancel_move_xy(int x, int y, gamestate * g){
  g->cases[x][y] = 0;
  g->firstToPlay = !g->firstToPlay;
  g->ended = 0;
}

void cancel_move(move * m, gamestate * g){
  cancel_move_xy(m->x, m->y, g);
}

int can_move_xy(int x, int y, gamestate * g){
  return g->cases[x][y] == 0;
}

int can_move(move * m, gamestate * g){
  return can_move_xy(m->x, m->y, g);
}

/*
Un minimax classique, renvoie la note du plateau
*/
int minmax(gamestate * g){
  int x, y;
  eval_(g);
  if (g->ended)
    return g->note;
  int maxNote = -10000;
  if (!g->firstToPlay)
    maxNote = 10000;
  for (x = 0 ; x <= 2; x++)
    for (y = 0 ; y <= 2; y++)
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
  int x, y;
  move * minMove = [move alloc];
  minMove->x=0;
  minMove->y=0;
  int minNote = 10000;
  for (x = 0 ; x <= 2; x++)
    for (y = 0 ; y <= 2; y++)
      if (can_move_xy(x, y, g))
  {
    apply_move_xy(x, y, g);
    int currentNote = minmax(g);
    printf("%d, %d, %d\n", x, y, currentNote);
    cancel_move_xy(x, y, g);
    if (currentNote < minNote)
    {
      minNote = currentNote;
      minMove->x = x;
      minMove->y = y;
    }
  }
  printf("%d%d\n", minMove->x, minMove->y);
  return minMove;
}

gamestate * init_(){
  int i, j;
  int* *cases = malloc( 3 * sizeof(int*));
  for (i = 0 ; i < 3; i++)
  {
    int *tab = malloc( 3 * sizeof(int));
    for (j = 0 ; j < 3; j++)
      tab[j] = 0;
    cases[i] = tab;
  }
  gamestate * a = [gamestate alloc];
  a->cases=cases;
  a->firstToPlay=1;
  a->note=0;
  a->ended=0;
  return a;
}

move * read_move(){
  int y, x;
  scanf("%d %d ", &x, &y);
  move * b = [move alloc];
  b->x=x;
  b->y=y;
  return b;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i;
  for (i = 0 ; i <= 1; i++)
  {
    gamestate * state = init_();
    move * c = [move alloc];
    c->x=1;
    c->y=1;
    apply_move(c, state);
    move * d = [move alloc];
    d->x=0;
    d->y=0;
    apply_move(d, state);
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
    printf("%d\n", state->note);
  }
  [pool drain];
  return 0;
}


