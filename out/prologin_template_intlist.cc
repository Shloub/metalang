#include <iostream>
#include <vector>

int programme_candidat(std::vector<int> * tableau, int taille) {
    int out0 = 0;
    for (int i = 0; i < taille; i++)
      out0 += tableau->at(i);
    return out0;
}


int main() {
    int taille;
    std::cin >> taille;
    std::vector<int> *tableau = new std::vector<int>( taille );
    for (int a = 0; a < taille; a++)
    {
        std::cin >> tableau->at(a);
    }
    std::cout << programme_candidat(tableau, taille) << "\n";
}

