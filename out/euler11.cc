#include <iostream>
#include <vector>
int max2_(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

int find(int n, std::vector<std::vector<int> *> * m, int x, int y, int dx, int dy){
  if (x < 0 || x == 20 || y < 0 || y == 20)
    return -1;
  else if (n == 0)
    return 1;
  else
    return m->at(y)->at(x) * find(n - 1, m, x + dx, y + dy, dx, dy);
}

class tuple_int_int {
public:
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
};


int main(){
  std::vector<tuple_int_int * > *directions = new std::vector<tuple_int_int *>( 8 );
  for (int i = 0 ; i < 8; i++)
    if (i == 0)
  {
    tuple_int_int * bh = new tuple_int_int();
    bh->tuple_int_int_field_0=0;
    bh->tuple_int_int_field_1=1;
    directions->at(i) = bh;
  }
  else if (i == 1)
  {
    tuple_int_int * bg = new tuple_int_int();
    bg->tuple_int_int_field_0=1;
    bg->tuple_int_int_field_1=0;
    directions->at(i) = bg;
  }
  else if (i == 2)
  {
    tuple_int_int * bf = new tuple_int_int();
    bf->tuple_int_int_field_0=0;
    bf->tuple_int_int_field_1=-1;
    directions->at(i) = bf;
  }
  else if (i == 3)
  {
    tuple_int_int * be = new tuple_int_int();
    be->tuple_int_int_field_0=-1;
    be->tuple_int_int_field_1=0;
    directions->at(i) = be;
  }
  else if (i == 4)
  {
    tuple_int_int * bd = new tuple_int_int();
    bd->tuple_int_int_field_0=1;
    bd->tuple_int_int_field_1=1;
    directions->at(i) = bd;
  }
  else if (i == 5)
  {
    tuple_int_int * bc = new tuple_int_int();
    bc->tuple_int_int_field_0=1;
    bc->tuple_int_int_field_1=-1;
    directions->at(i) = bc;
  }
  else if (i == 6)
  {
    tuple_int_int * bb = new tuple_int_int();
    bb->tuple_int_int_field_0=-1;
    bb->tuple_int_int_field_1=1;
    directions->at(i) = bb;
  }
  else
  {
    tuple_int_int * ba = new tuple_int_int();
    ba->tuple_int_int_field_0=-1;
    ba->tuple_int_int_field_1=-1;
    directions->at(i) = ba;
  }
  int max0 = 0;
  int h = 20;
  std::vector<std::vector<int> * > *m = new std::vector<std::vector<int> *>( 20 );
  for (int o = 0 ; o < 20; o++)
  {
    std::vector<int > *s = new std::vector<int>( h );
    for (int q = 0 ; q < h; q++)
    {
      std::cin >> s->at(q) >> std::skipws;
    }
    m->at(o) = s;
  }
  for (int j = 0 ; j <= 7; j ++)
  {
    tuple_int_int * w = directions->at(j);
    int dx = w->tuple_int_int_field_0;
    int dy = w->tuple_int_int_field_1;
    for (int x = 0 ; x <= 19; x ++)
      for (int y = 0 ; y <= 19; y ++)
        max0 = max2_(max0, find(4, m, x, y, dx, dy));
  }
  std::cout << max0 << "\n";
  return 0;
}

