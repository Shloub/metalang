#include <iostream>
#include <vector>
#include <algorithm>

int find(int n, std::vector<std::vector<int> *> * m, int x, int y, int dx, int dy) {
    if (x < 0 || x == 20 || y < 0 || y == 20)
        return -1;
    else if (n == 0)
        return 1;
    else
        return m->at(y)->at(x) * find(n - 1, m, x + dx, y + dy, dx, dy);
}

struct tuple_int_int {
    int tuple_int_int_field_0;
    int tuple_int_int_field_1;
};

int main() {
    std::vector<tuple_int_int *> *directions = new std::vector<tuple_int_int *>( 8 );
    for (int i = 0; i < 8; i++)
        if (i == 0)
        {
            tuple_int_int * c = new tuple_int_int();
                c->tuple_int_int_field_0 = 0;
                c->tuple_int_int_field_1 = 1;;
            directions->at(i) = c;
        }
        else if (i == 1)
        {
            tuple_int_int * d = new tuple_int_int();
                d->tuple_int_int_field_0 = 1;
                d->tuple_int_int_field_1 = 0;;
            directions->at(i) = d;
        }
        else if (i == 2)
        {
            tuple_int_int * e = new tuple_int_int();
                e->tuple_int_int_field_0 = 0;
                e->tuple_int_int_field_1 = -1;;
            directions->at(i) = e;
        }
        else if (i == 3)
        {
            tuple_int_int * f = new tuple_int_int();
                f->tuple_int_int_field_0 = -1;
                f->tuple_int_int_field_1 = 0;;
            directions->at(i) = f;
        }
        else if (i == 4)
        {
            tuple_int_int * g = new tuple_int_int();
                g->tuple_int_int_field_0 = 1;
                g->tuple_int_int_field_1 = 1;;
            directions->at(i) = g;
        }
        else if (i == 5)
        {
            tuple_int_int * h = new tuple_int_int();
                h->tuple_int_int_field_0 = 1;
                h->tuple_int_int_field_1 = -1;;
            directions->at(i) = h;
        }
        else if (i == 6)
        {
            tuple_int_int * k = new tuple_int_int();
                k->tuple_int_int_field_0 = -1;
                k->tuple_int_int_field_1 = 1;;
            directions->at(i) = k;
        }
        else
        {
            tuple_int_int * l = new tuple_int_int();
                l->tuple_int_int_field_0 = -1;
                l->tuple_int_int_field_1 = -1;;
            directions->at(i) = l;
        }
    int max0 = 0;
    std::vector<std::vector<int> *> *m = new std::vector<std::vector<int> *>( 20 );
    for (int o = 0; o < 20; o++)
    {
        std::vector<int> *p = new std::vector<int>( 20 );
        for (int q = 0; q < 20; q++)
        {
            std::cin >> p->at(q);
        }
        m->at(o) = p;
    }
    for (int j = 0; j < 8; j++)
    {
        tuple_int_int * r = directions->at(j);
        int dx = r->tuple_int_int_field_0;
        int dy = r->tuple_int_int_field_1;
        for (int x = 0; x < 20; x++)
            for (int y = 0; y < 20; y++)
                max0 = std::max(max0, find(4, m, x, y, dx, dy));
    }
    std::cout << max0 << "\n";
}

