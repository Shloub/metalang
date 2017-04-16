#include <stdio.h>
#include <stdlib.h>

typedef struct toto {
  char* s;
    int v;
} toto;

char* idstring(char* s) {
    return s;
}

void printstring(char* s) {
    printf("%s\n", idstring(s));
}

void print_toto(struct toto * t) {
    printf("%s = %d\n", t->s, t->v);
}
int main(void) {
    int j, i;
    char* *tab = calloc(2, sizeof(char*));
    for (i = 0; i < 2; i++)
        tab[i] = idstring("chaine de test");
    for (j = 0; j < 2; j++)
        printstring(idstring(tab[j]));
    struct toto * a = malloc(sizeof(toto));
    a->s = "one";
    a->v = 1;
    print_toto(a);
    return 0;
}


