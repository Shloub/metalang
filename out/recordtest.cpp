#include <iostream>
#include <vector>
struct toto {
    int foo;
    int bar;
};


int main() {
    toto param;
    param.foo = 0;
    param.bar = 0;
    std::cin >> param.bar >> param.foo >> std::noskipws;
    std::cout << param.bar + param.foo * param.bar;
}

