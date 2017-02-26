#include <iostream>
#include <vector>

void foo(int a) {
    a = 4;
}

int main() {
    int a = 0;
    foo(a);
    std::cout << a << "\n";
}

