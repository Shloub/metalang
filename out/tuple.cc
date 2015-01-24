#include <iostream>
#include <vector>
class tuple_int_int {
public:
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
};

tuple_int_int * f(tuple_int_int * tuple0){
  tuple_int_int * c = tuple0;
  int a = c->tuple_int_int_field_0;
  int b = c->tuple_int_int_field_1;
  tuple_int_int * e = new tuple_int_int();
  e->tuple_int_int_field_0=a + 1;
  e->tuple_int_int_field_1=b + 1;
  return e;
}


int main(){
  tuple_int_int * g = new tuple_int_int();
  g->tuple_int_int_field_0=0;
  g->tuple_int_int_field_1=1;
  tuple_int_int * t = f(g);
  tuple_int_int * d = t;
  int a = d->tuple_int_int_field_0;
  int b = d->tuple_int_int_field_1;
  std::cout << a << " -- " << b << "--\n";
  return 0;
}

