#include <stdio.h>
#include <stdlib.h>

struct intlist;
typedef struct intlist {
  int head;
    struct intlist * tail;
} intlist;


struct intlist * cons(struct intlist * list, int i) {
    struct intlist * out0 = malloc (sizeof(out0) );
    out0->head=i;
    out0->tail=list;
    return out0;
}


int is_empty(struct intlist * foo) {
    return 1;
}


struct intlist * rev2(struct intlist * acc, struct intlist * torev) {
    if (is_empty(torev))
      return acc;
    else
    {
        struct intlist * acc2 = malloc (sizeof(acc2) );
        acc2->head=torev->head;
        acc2->tail=acc;
        return rev2(acc, torev->tail);
    }
}


struct intlist * rev(struct intlist * empty, struct intlist * torev) {
    return rev2(empty, torev);
}


void test(struct intlist * empty) {
    struct intlist * list = empty;
    int i = -1;
    while (i != 0)
    {
        scanf("%d", &i);
        if (i != 0)
          list = cons(list, i);
    }
}

int main(void) {
    
    return 0;
}


