#include <iostream>
#include <vector>

int main() {
    std::cout << "Hello World";
    int a = 5;
    std::cout << (4 + 6) * 2 << " \n" << a << "foo";
    if (1 + 2 * 2 * (3 + 8) / 4 - 2 == 12 && true)
        std::cout << "True";
    else
        std::cout << "False";
    std::cout << "\n";
    if ((3 * (4 + 11) * 2 == 45) == false)
        std::cout << "True";
    else
        std::cout << "False";
    std::cout << " ";
    if ((2 == 1) == false)
        std::cout << "True";
    else
        std::cout << "False";
    std::cout << " " << 5 / 3 / 3 << 4 * 1 / 3 / 2 * 1;
    if (!(!(a == 0) && !(a == 4)))
        std::cout << "True";
    else
        std::cout << "False";
    if (true && !false && !(true && false))
        std::cout << "True";
    else
        std::cout << "False";
    std::cout << "\n";
}

