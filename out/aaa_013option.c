#include <stdio.h>
#include <stdlib.h>

typedef struct foo {
  int a;
    int* b;
    int* c;
    int** d;
    int* e;
    struct foo * f;
    struct foo ** g;
    struct foo ** h;
} foo;

int default0(int* a, struct foo * b, int** c, struct foo ** d, int* e, struct foo ** f) {
    return 0;
}

void aa(struct foo * b) {
    
}
int main(void) {
    printf("___\n");
    return 0;
}


