#include <iostream>
#include <vector>
struct tuple_int_int {
    int tuple_int_int_field_0;
    int tuple_int_int_field_1;
};

struct toto {
    tuple_int_int * foo;
    int bar;
};

int main() {
    int d, c, bar_;
    std::cin >> bar_ >> c >> d;
    tuple_int_int * e = new tuple_int_int();
        e->tuple_int_int_field_0 = c;
        e->tuple_int_int_field_1 = d;;
    toto * t = new toto();
        t->foo = e;
        t->bar = bar_;;
    tuple_int_int * f = t->foo;
    int a = f->tuple_int_int_field_0;
    int b = f->tuple_int_int_field_1;
    std::cout << a << " " << b << " " << t->bar << "\n";
}

