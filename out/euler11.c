#include <stdio.h>
#include <stdlib.h>


int max2_(int a, int b) {
    if (a > b)
        return a;
    else
        return b;
}


int find(int n, int** m, int x, int y, int dx, int dy) {
    if (x < 0 || x == 20 || y < 0 || y == 20)
        return -1;
    else if (n == 0)
        return 1;
    else
        return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy);
}

typedef struct tuple_int_int {
  int tuple_int_int_field_0;
    int tuple_int_int_field_1;
} tuple_int_int;
int main(void) {
    int j, x, y, o, q, i;
    struct tuple_int_int * *directions = calloc(8, sizeof(struct tuple_int_int *));
    for (i = 0; i < 8; i++)
        if (i == 0)
        {
            struct tuple_int_int * c = malloc(sizeof(tuple_int_int));
            c->tuple_int_int_field_0 = 0;
            c->tuple_int_int_field_1 = 1;
            directions[i] = c;
        }
        else if (i == 1)
        {
            struct tuple_int_int * d = malloc(sizeof(tuple_int_int));
            d->tuple_int_int_field_0 = 1;
            d->tuple_int_int_field_1 = 0;
            directions[i] = d;
        }
        else if (i == 2)
        {
            struct tuple_int_int * e = malloc(sizeof(tuple_int_int));
            e->tuple_int_int_field_0 = 0;
            e->tuple_int_int_field_1 = -1;
            directions[i] = e;
        }
        else if (i == 3)
        {
            struct tuple_int_int * f = malloc(sizeof(tuple_int_int));
            f->tuple_int_int_field_0 = -1;
            f->tuple_int_int_field_1 = 0;
            directions[i] = f;
        }
        else if (i == 4)
        {
            struct tuple_int_int * g = malloc(sizeof(tuple_int_int));
            g->tuple_int_int_field_0 = 1;
            g->tuple_int_int_field_1 = 1;
            directions[i] = g;
        }
        else if (i == 5)
        {
            struct tuple_int_int * h = malloc(sizeof(tuple_int_int));
            h->tuple_int_int_field_0 = 1;
            h->tuple_int_int_field_1 = -1;
            directions[i] = h;
        }
        else if (i == 6)
        {
            struct tuple_int_int * k = malloc(sizeof(tuple_int_int));
            k->tuple_int_int_field_0 = -1;
            k->tuple_int_int_field_1 = 1;
            directions[i] = k;
        }
        else
        {
            struct tuple_int_int * l = malloc(sizeof(tuple_int_int));
            l->tuple_int_int_field_0 = -1;
            l->tuple_int_int_field_1 = -1;
            directions[i] = l;
        }
    int max0 = 0;
    int* *m = calloc(20, sizeof(int*));
    for (o = 0; o < 20; o++)
    {
        int *p = calloc(20, sizeof(int));
        for (q = 0; q < 20; q++)
            scanf("%d ", &p[q]);
        m[o] = p;
    }
    for (j = 0; j < 8; j++)
    {
        struct tuple_int_int * r = directions[j];
        int dx = r->tuple_int_int_field_0;
        int dy = r->tuple_int_int_field_1;
        for (x = 0; x < 20; x++)
            for (y = 0; y < 20; y++)
                max0 = max2_(max0, find(4, m, x, y, dx, dy));
    }
    printf("%d\n", max0);
    return 0;
}


