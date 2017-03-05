#include <stdio.h>
#include <stdlib.h>

typedef struct toto {
  int foo;
    int bar;
} toto;int main(void) {
           struct toto * param = malloc(sizeof(toto));
           param->foo = 0;
           param->bar = 0;
           scanf("%d %d", &param->bar, &param->foo);
           printf("%d", param->bar + param->foo * param->bar);
           return 0;
}


