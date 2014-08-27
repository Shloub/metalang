#include <iostream>
#include <vector>
int max2(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

std::vector<std::vector<int> *> * read_int_matrix(int x, int y){
  int f;
  std::vector<std::vector<int> * > *tab = new std::vector<std::vector<int> *>( y );
  for (int z = 0 ; z < y; z++)
  {
    std::vector<int > *d = new std::vector<int>( x );
    for (int e = 0 ; e < x; e++)
    {
      std::cin >> f >> std::skipws;
      d->at(e) = f;
    }
    tab->at(z) = d;
  }
  return tab;
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
    tuple_int_int * s = new tuple_int_int();
    s->tuple_int_int_field_0=0;
    s->tuple_int_int_field_1=1;
    directions->at(i) = s;
  }
  else if (i == 1)
  {
    tuple_int_int * r = new tuple_int_int();
    r->tuple_int_int_field_0=1;
    r->tuple_int_int_field_1=0;
    directions->at(i) = r;
  }
  else if (i == 2)
  {
    tuple_int_int * q = new tuple_int_int();
    q->tuple_int_int_field_0=0;
    q->tuple_int_int_field_1=-1;
    directions->at(i) = q;
  }
  else if (i == 3)
  {
    tuple_int_int * p = new tuple_int_int();
    p->tuple_int_int_field_0=-1;
    p->tuple_int_int_field_1=0;
    directions->at(i) = p;
  }
  else if (i == 4)
  {
    tuple_int_int * o = new tuple_int_int();
    o->tuple_int_int_field_0=1;
    o->tuple_int_int_field_1=1;
    directions->at(i) = o;
  }
  else if (i == 5)
  {
    tuple_int_int * l = new tuple_int_int();
    l->tuple_int_int_field_0=1;
    l->tuple_int_int_field_1=-1;
    directions->at(i) = l;
  }
  else if (i == 6)
  {
    tuple_int_int * k = new tuple_int_int();
    k->tuple_int_int_field_0=-1;
    k->tuple_int_int_field_1=1;
    directions->at(i) = k;
  }
  else
  {
    tuple_int_int * h = new tuple_int_int();
    h->tuple_int_int_field_0=-1;
    h->tuple_int_int_field_1=-1;
    directions->at(i) = h;
  }
  int max_ = 0;
  std::vector<std::vector<int> *> * m = read_int_matrix(20, 20);
  for (int j = 0 ; j <= 7; j ++)
  {
    tuple_int_int * g = directions->at(j);
    int dx = g->tuple_int_int_field_0;
    int dy = g->tuple_int_int_field_1;
    for (int x = 0 ; x <= 19; x ++)
      for (int y = 0 ; y <= 19; y ++)
        max_ = max2(max_, find(4, m, x, y, dx, dy));
  }
  std::cout << max_ << "\n";
  return 0;
}

