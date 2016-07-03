#include <iostream>
#include <vector>
/*
La suite de fibonaci
*/

int fibo0(int a, int b, int i) {
    int out0 = 0;
    int a2 = a;
    int b2 = b;
    for (int j = 0; j <= i + 1; j += 1)
    {
        out0 += a2;
        int tmp = b2;
        b2 += a2;
        a2 = tmp;
    }
    return out0;
}


int main(void) {
    int a = 0;
    int b = 0;
    int i = 0;
    std::cin >> a >> b >> i >> std::noskipws;
    std::cout << fibo0(a, b, i);
    return 0;
}
