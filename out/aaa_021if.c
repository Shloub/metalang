#include <stdio.h>
#include <stdlib.h>


void testA(int a, int b) {
    if (a)
        if (b)
            printf("A");
        else
            printf("B");
    else if (b)
        printf("C");
    else
        printf("D");
}


void testB(int a, int b) {
    if (a)
        printf("A");
    else if (b)
        printf("B");
    else
        printf("C");
}


void testC(int a, int b) {
    if (a)
        if (b)
            printf("A");
        else
            printf("B");
    else
        printf("C");
}


void testD(int a, int b) {
    if (a)
    {
        if (b)
            printf("A");
        else
            printf("B");
        printf("C");
    }
    else
        printf("D");
}


void testE(int a, int b) {
    if (a)
    {
        if (b)
            printf("A");
    }
    else
    {
        if (b)
            printf("C");
        else
            printf("D");
        printf("E");
    }
}


void test(int a, int b) {
    testD(a, b);
    testE(a, b);
    printf("\n");
}

int main(void) {
    test(1, 1);
    test(1, 0);
    test(0, 1);
    test(0, 0);
    return 0;
}


