#include <iostream>
#include <vector>
typedef struct toto {
  std::string s;
    int v;
} toto;


std::string idstring(std::string s) {
    return s;
}


void printstring(std::string s) {
    std::cout << idstring(s) << "\n";
}


void print_toto(toto& t) {
    std::cout << t.s << " = " << t.v << "\n";
}


int main() {
    std::vector<std::string> tab( 2 );
    for (int i = 0; i <= 1; i += 1)
        tab[i] = idstring("chaine de test");
    for (int j = 0; j <= 1; j += 1)
        printstring(idstring(tab[j]));
    toto a;
        a.s = "one";
        a.v = 1;;
    print_toto(a);
}

