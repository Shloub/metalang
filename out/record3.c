#include <stdio.h>
#include <stdlib.h>

typedef struct toto {
  int foo;
    int bar;
    int blah;
} toto;


struct toto * mktoto(int v1) {
    struct toto * t = malloc(sizeof(toto));
    t->foo = v1;
    t->bar = 0;
    t->blah = 0;
    return t;
}


int result(struct toto ** t, int len) {
    int j;
    int out0 = 0;
    for (j = 0; j < len; j++)
    {
        t[j]->blah++;
        out0 = out0 + t[j]->foo + t[j]->blah * t[j]->bar + t[j]->bar * t[j]->foo;
    }
    return out0;
}

int main(void) {
    int i;
    struct toto * *t = calloc(4, sizeof(struct toto *));
    for (i = 0; i < 4; i++)
        t[i] = mktoto(i);
    scanf("%d %d", &t[0]->bar, &t[1]->blah);
    int titi = result(t, 4);
    printf("%d%d", titi, t[2]->blah);
    return 0;
}


