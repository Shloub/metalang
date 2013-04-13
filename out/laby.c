#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }


struct case_state;
typedef struct case_state {
  int left;
  int right;
  int top;
  int bottom;
  int free;
} case_state;

struct laby;
typedef struct laby {
  int sizeX;
  int sizeY;
  struct case_state *** cases;
} laby;

int can_open_right(struct laby * state, int x, int y){
  return (x < (state->sizeX - 1)) && state->cases[x + 1][y]->free;
}

int can_open_left(struct laby * state, int x, int y){
  return (x > 0) && state->cases[x - 1][y]->free;
}

int can_open_bottom(struct laby * state, int x, int y){
  return (y < (state->sizeY - 1)) && state->cases[x][y + 1]->free;
}

int can_open_top(struct laby * state, int x, int y){
  return (y > 0) && state->cases[x][y - 1]->free;
}

void open_left(struct laby * state, int x, int y){
  state->cases[x - 1][y]->right = 0;
  state->cases[x][y]->left = 0;
  state->cases[x - 1][y]->free = 0;
  state->cases[x][y]->free = 0;
}

void open_right(struct laby * state, int x, int y){
  state->cases[x][y]->right = 0;
  state->cases[x + 1][y]->left = 0;
  state->cases[x][y]->free = 0;
  state->cases[x + 1][y]->free = 0;
}

void open_top(struct laby * state, int x, int y){
  state->cases[x][y - 1]->bottom = 0;
  state->cases[x][y]->top = 0;
  state->cases[x][y - 1]->free = 0;
  state->cases[x][y]->free = 0;
}

void open_bottom(struct laby * state, int x, int y){
  state->cases[x][y + 1]->top = 0;
  state->cases[x][y]->bottom = 0;
  state->cases[x][y + 1]->free = 0;
  state->cases[x][y]->free = 0;
}

struct laby * init(int x, int y){
  struct case_state ** *cases = malloc( (x) * sizeof(struct case_state **) + sizeof(int));
  ((int*)cases)[0]=x;
  cases=(struct case_state ***)( ((int*)cases)+1);
  {
    int i;
    for (i = 0 ; i <= x - 1; i++)
    {
      struct case_state * *cases_x = malloc( (y) * sizeof(struct case_state *) + sizeof(int));
      ((int*)cases_x)[0]=y;
      cases_x=(struct case_state **)( ((int*)cases_x)+1);
      {
        int j;
        for (j = 0 ; j <= y - 1; j++)
        {
          struct case_state * reco = malloc (sizeof(reco) );
          reco->left=1;
          reco->right=1;
          reco->top=1;
          reco->bottom=1;
          reco->free=1;
          cases_x[j] = reco;
        }
      }
      cases[i] = cases_x;
    }
  }
  struct laby * out_ = malloc (sizeof(out_) );
  out_->sizeX=x;
  out_->sizeY=y;
  out_->cases=cases;
  return out_;
}

void print_lab(struct laby * l){
  {
    int x;
    for (x = 0 ; x <= l->sizeX - 1; x++)
    {
      printf("%s", "__");
    }
  }
  printf("%s", "\n");
  {
    int y;
    for (y = 0 ; y <= l->sizeY - 1; y++)
    {
      {
        int x;
        for (x = 0 ; x <= l->sizeX - 1; x++)
        {
          if (l->cases[x][y]->left)
          {
            if (l->cases[x][y]->bottom)
            {
              printf("%s", "|_");
            }
            else
            {
              printf("%s", "| ");
            }
          }
          else if (l->cases[x][y]->bottom)
          {
            printf("%s", "__");
          }
          else
          {
            printf("%s", "  ");
          }
        }
      }
      printf("%s", "|\n");
    }
  }
  printf("%s", "\n");
}

void gen(struct laby * lab, int x, int y){
  int a = 4;
  int *order = malloc( (a) * sizeof(int) + sizeof(int));
  ((int*)order)[0]=a;
  order=(int*)( ((int*)order)+1);
  {
    int i;
    for (i = 0 ; i <= a - 1; i++)
    {
      order[i] = i;
    }
  }
  {
    int i;
    for (i = 0 ; i <= 2; i++)
    {
      int j = 4 -
i;
      int k = order[i];
      order[i] = order[j];
      order[j] = k;
    }
  }
  {
    int i;
    for (i = 0 ; i <= 3; i++)
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
}

int main(void){
  struct laby * lab = init(10, 10);
  gen(lab, 0, 0);
  print_lab(lab);
  return 0;
}


