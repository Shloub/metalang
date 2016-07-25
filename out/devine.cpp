#include <iostream>
#include <vector>

bool devine0(int nombre, std::vector<int>& tab, int len) {
    int min0 = tab[0];
    int max0 = tab[1];
    for (int i = 2; i < len; i++)
    {
        if (tab[i] > max0 || tab[i] < min0)
            return false;
        if (tab[i] < nombre)
            min0 = tab[i];
        if (tab[i] > nombre)
            max0 = tab[i];
        if (tab[i] == nombre && len != i + 1)
            return false;
    }
    return true;
}


int main() {
    int tmp, len, nombre;
    std::cin >> nombre >> len;
    std::vector<int> tab( len );
    for (int i = 0; i < len; i++)
    {
        std::cin >> tmp;
        tab[i] = tmp;
    }
    if (devine0(nombre, tab, len))
        std::cout << "True";
    else
        std::cout << "False";
}

