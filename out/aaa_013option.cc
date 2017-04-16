#include <iostream>
#include <vector>
struct foo {
    int a;
    int* b;
    std::vector<int> * c;
    std::vector<int*> * d;
    std::vector<int> * e;
    foo * f;
    std::vector<foo *> * g;
    std::vector<foo *> * h;
};


int default0(int* a, foo * b, std::vector<int*> * c, std::vector<foo *> * d, std::vector<int> * e, std::vector<foo *> * f) {
    return 0;
}


void aa(foo * b) {
    
}

int main() {
    std::cout << "___\n";
}

