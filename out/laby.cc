#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>

struct case_state;
typedef struct case_state {
  bool left;
  bool right;
  bool top;
  bool bottom;
  bool free;
} case_state;

struct laby;
typedef struct laby {
  int sizeX;
  int sizeY;
  std::vector<std::vector<struct case_state * > > cases;
} laby;

bool can_open_right(struct laby * state, int x, int y){
  return (x < (state->sizeX - 1)) && state->cases.at(x + 1).at(y)->free;
}

bool can_open_left(struct laby * state, int x, int y){
  return (x > 0) && state->cases.at(x - 1).at(y)->free;
}

bool can_open_bottom(struct laby * state, int x, int y){
  return (y < (state->sizeY - 1)) && state->cases.at(x).at(y + 1)->free;
}

bool can_open_top(struct laby * state, int x, int y){
  return (y > 0) && state->cases.at(x).at(y - 1)->free;
}

void open_left(struct laby * state, int x, int y){
  state->cases.at(x - 1).at(y)->right = false;
  state->cases.at(x).at(y)->left = false;
  state->cases.at(x - 1).at(y)->free = false;
  state->cases.at(x).at(y)->free = false;
}

void open_right(struct laby * state, int x, int y){
  state->cases.at(x).at(y)->right = false;
  state->cases.at(x + 1).at(y)->left = false;
  state->cases.at(x).at(y)->free = false;
  state->cases.at(x + 1).at(y)->free = false;
}

void open_top(struct laby * state, int x, int y){
  state->cases.at(x).at(y - 1)->bottom = false;
  state->cases.at(x).at(y)->top = false;
  state->cases.at(x).at(y - 1)->free = false;
  state->cases.at(x).at(y)->free = false;
}

void open_bottom(struct laby * state, int x, int y){
  state->cases.at(x).at(y + 1)->top = false;
  state->cases.at(x).at(y)->bottom = false;
  state->cases.at(x).at(y + 1)->free = false;
  state->cases.at(x).at(y)->free = false;
}

struct laby * init(int x, int y){
  std::vector<std::vector<struct case_state * > > cases( x );
  for (int i = 0 ; i <= x - 1; i ++)
  {
    std::vector<struct case_state * > cases_x( y );
    for (int j = 0 ; j <= y - 1; j ++)
    {
      struct case_state * reco = new case_state();
      reco->left=true;
      reco->right=true;
      reco->top=true;
      reco->bottom=true;
      reco->free=true;
      cases_x.at(j) = reco;
    }
    cases.at(i) = cases_x;
  }
  struct laby * out_ = new laby();
  out_->sizeX=x;
  out_->sizeY=y;
  out_->cases=cases;
  return out_;
}

void print_lab(struct laby * l){
  for (int x = 0 ; x <= l->sizeX - 1; x ++)
  {
    std::cout << "__";
  }
  std::cout << "\n";
  for (int y = 0 ; y <= l->sizeY - 1; y ++)
  {
    for (int x = 0 ; x <= l->sizeX - 1; x ++)
    {
      if (l->cases.at(x).at(y)->left)
      {
        if (l->cases.at(x).at(y)->bottom)
        {
          std::cout << "|_";
        }
        else
        {
          std::cout << "| ";
        }
      }
      else if (l->cases.at(x).at(y)->bottom)
      {
        std::cout << "__";
      }
      else
      {
        std::cout << "  ";
      }
    }
    std::cout << "|\n";
  }
  std::cout << "\n";
}

void gen(struct laby * lab, int x, int y){
  int d = 4;
  std::vector<int > order( d );
  for (int i = 0 ; i <= d - 1; i ++)
  {
    order.at(i) = i;
  }
  for (int i = 0 ; i <= 2; i ++)
  {
    int j = 4 -
i;
    int k = order.at(i);
    order.at(i) = order.at(j);
    order.at(j) = k;
  }
  for (int i = 0 ; i <= 3; i ++)
  {
    if ((0 == order.at(i)) && can_open_left(lab, x, y))
    {
      open_left(lab, x, y);
      gen(lab, x - 1, y);
    }
    if ((1 == order.at(i)) && can_open_right(lab, x, y))
    {
      open_right(lab, x, y);
      gen(lab, x + 1, y);
    }
    if ((2 == order.at(i)) && can_open_top(lab, x, y))
    {
      open_top(lab, x, y);
      gen(lab, x, y - 1);
    }
    if ((3 == order.at(i)) && can_open_bottom(lab, x, y))
    {
      open_bottom(lab, x, y);
      gen(lab, x, y + 1);
    }
  }
}


int main(void){
  struct laby * lab = init(10, 10);
  gen(lab, 0, 0);
  print_lab(lab);
  return 0;
}

