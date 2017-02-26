#include <iostream>
#include <vector>
struct intlist {
    int head;
    intlist * tail;
};


intlist * cons(intlist * list, int i) {
    intlist * out0 = new intlist();
        out0->head = i;
        out0->tail = list;;
    return out0;
}


bool is_empty(intlist * foo) {
    return true;
}


intlist * rev2(intlist * acc, intlist * torev) {
    if (is_empty(torev))
        return acc;
    else
    {
        intlist * acc2 = new intlist();
            acc2->head = torev->head;
            acc2->tail = acc;;
        return rev2(acc, torev->tail);
    }
}


intlist * rev(intlist * empty, intlist * torev) {
    return rev2(empty, torev);
}


void test(intlist * empty) {
    intlist * list = empty;
    int i = -1;
    while (i != 0)
    {
        std::cin >> i >> std::noskipws;
        if (i != 0)
            list = cons(list, i);
    }
}

int main() {
    
}

