#include <stdio.h>
#include <stdlib.h>

/* 
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
 */

typedef struct toto {
  int foo;
    int bar;
    int blah;
} toto;


struct toto * mktoto(int v1) {
    struct toto * t = malloc(sizeof(toto));
    t->foo = v1;
    t->bar = v1;
    t->blah = v1;
    return t;
}


struct toto * mktoto2(int v1) {
    struct toto * t = malloc(sizeof(toto));
    t->foo = v1 + 3;
    t->bar = v1 + 2;
    t->blah = v1 + 1;
    return t;
}


int result(struct toto * t_, struct toto * t2_) {
    int j, i;
    struct toto * t = t_;
    struct toto * t2 = t2_;
    struct toto * t3 = malloc(sizeof(toto));
    t3->foo = 0;
    t3->bar = 0;
    t3->blah = 0;
    t3 = t2;
    t = t2;
    t2 = t3;
    t->blah++;
    int len = 1;
    int *cache0 = calloc(len, sizeof(int));
    for (i = 0; i < len; i++)
        cache0[i] = -i;
    int *cache1 = calloc(len, sizeof(int));
    for (j = 0; j < len; j++)
        cache1[j] = j;
    int* cache2 = cache0;
    cache0 = cache1;
    cache2 = cache0;
    return t->foo + t->blah * t->bar + t->bar * t->foo;
}

int main(void) {
    struct toto * t = mktoto(4);
    struct toto * t2 = mktoto(5);
    scanf("%d %d %d %d", &t->bar, &t->blah, &t2->bar, &t2->blah);
    printf("%d%d", result(t, t2), t->blah);
    return 0;
}


