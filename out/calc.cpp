#include <iostream>
#include <vector>
/*
La suite de fibonaci
*/


int fibo(int a, int b, int i) {
    int out_ = 0;
    int a2 = a;
    int b2 = b;
    for (int j = 0; j <= i + 1; j++)
    {
        std::cout << j;
        out_ += a2;
        int tmp = b2;
        b2 += a2;
        a2 = tmp;
    }
    return out_;
}


int main() {
    std::cout << fibo(1, 2, 4);
}

