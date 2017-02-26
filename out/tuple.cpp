#include <iostream>
#include <vector>
struct tuple_int_int {
    int tuple_int_int_field_0;
    int tuple_int_int_field_1;
};


tuple_int_int f(tuple_int_int& tuple0) {
    tuple_int_int c = tuple0;
    int a = c.tuple_int_int_field_0;
    int b = c.tuple_int_int_field_1;
    tuple_int_int d;
        d.tuple_int_int_field_0 = a + 1;
        d.tuple_int_int_field_1 = b + 1;;
    return d;
}

int main() {
    tuple_int_int e;
        e.tuple_int_int_field_0 = 0;
        e.tuple_int_int_field_1 = 1;;
    tuple_int_int t = f(e);
    tuple_int_int g = t;
    int a = g.tuple_int_int_field_0;
    int b = g.tuple_int_int_field_1;
    std::cout << a << " -- " << b << "--\n";
}

