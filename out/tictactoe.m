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
  printf("\n|");
  {
    int y;
    for (y = 0 ; y <= 2; y++)
    {
      {
        int x;
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
      }
      if (y != 2)
        printf("\n|-|-|-|\n|");
    }
  }
  printf("\n");
}

/* On dit qui gagne (info stoquées dans g.ended et g.note ) */
void eval_(gamestate * g){
  int win = 0;
  int freecase = 0;
  {
    int y;
    for (y = 0 ; y <= 2; y++)
    {
      int col = -1;
      int lin = -1;
      {
        int x;
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
      }
      if (col >= 0)
        win = col;
      else if (lin >= 0)
        win = lin;
    }
  }
  {
    int x;
    for (x = 1 ; x <= 2; x++)
    {
      if (g->cases[0][0] == x && g->cases[1][1] == x && g->cases[2][2] == x)
        win = x;
      if (g->cases[0][2] == x && g->cases[1][1] == x && g->cases[2][0] == x)
        win = x;
    }
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
  eval_(g);
  if (g->ended)
    return g->note;
  int maxNote = -10000;
  if (!g->firstToPlay)
    maxNote = 10000;
  {
    int x;
    for (x = 0 ; x <= 2; x++)
      {
      int y;
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
    }
  }
  return maxNote;
}

/*
Renvoie le coup de l'IA
*/
move * play(gamestate * g){
  move * minMove = [move alloc];
  minMove->x=0;
  minMove->y=0;
  int minNote = 10000;
  {
    int x;
    for (x = 0 ; x <= 2; x++)
      {
      int y;
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
    }
  }
  int a = minMove->x;
  printf("%d", a);
  int b = minMove->y;
  printf("%d\n", b);
  return minMove;
}

gamestate * init_(){
  int d = 3;
  int* *cases = malloc( d * sizeof(int*));
  {
    int i;
    for (i = 0 ; i < d; i++)
    {
      int c = 3;
      int *tab = malloc( c * sizeof(int));
      {
        int j;
        for (j = 0 ; j < c; j++)
          tab[j] = 0;
      }
      cases[i] = tab;
    }
  }
  gamestate * f = [gamestate alloc];
  f->cases=cases;
  f->firstToPlay=1;
  f->note=0;
  f->ended=0;
  return f;
}

move * read_move(){
  int x = 0;
  scanf("%d ", &x);
  int y = 0;
  scanf("%d ", &y);
  move * h = [move alloc];
  h->x=x;
  h->y=y;
  return h;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  {
    int i;
    for (i = 0 ; i <= 1; i++)
    {
      gamestate * state = init_();
      move * k = [move alloc];
      k->x=1;
      k->y=1;
      apply_move(k, state);
      move * l = [move alloc];
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
      printf("%d\n", e);
    }
  }
  [pool drain];
  return 0;
}


