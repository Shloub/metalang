#include <iostream>
#include <vector>

void testA(bool a, bool b) {
    if (a)
        if (b)
            std::cout << "A";
        else
            std::cout << "B";
    else if (b)
        std::cout << "C";
    else
        std::cout << "D";
}


void testB(bool a, bool b) {
    if (a)
        std::cout << "A";
    else if (b)
        std::cout << "B";
    else
        std::cout << "C";
}


void testC(bool a, bool b) {
    if (a)
        if (b)
            std::cout << "A";
        else
            std::cout << "B";
    else
        std::cout << "C";
}


void testD(bool a, bool b) {
    if (a)
    {
        if (b)
            std::cout << "A";
        else
            std::cout << "B";
        std::cout << "C";
    }
    else
        std::cout << "D";
}


void testE(bool a, bool b) {
    if (a)
    {
        if (b)
            std::cout << "A";
    }
    else
    {
        if (b)
            std::cout << "C";
        else
            std::cout << "D";
        std::cout << "E";
    }
}


void test(bool a, bool b) {
    testD(a, b);
    testE(a, b);
    std::cout << "\n";
}

int main() {
    test(true, true);
    test(true, false);
    test(false, true);
    test(false, false);
}

