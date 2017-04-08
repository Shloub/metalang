#include <iostream>
#include <vector>
/* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
on le retrouve ici : http://projecteuler.net/problem=18
*/

int find0(int len, std::vector<std::vector<int>>& tab, std::vector<std::vector<int>>& cache, int x, int y) {
    /*
	Cette fonction est récursive
	*/
    if (y == len - 1)
        return tab[y][x];
    else if (x > y)
        return -10000;
    else if (cache[y][x] != 0)
        return cache[y][x];
    int result = 0;
    int out0 = find0(len, tab, cache, x, y + 1);
    int out1 = find0(len, tab, cache, x + 1, y + 1);
    if (out0 > out1)
        result = out0 + tab[y][x];
    else
        result = out1 + tab[y][x];
    cache[y][x] = result;
    return result;
}


int find(int len, std::vector<std::vector<int>>& tab) {
    std::vector<std::vector<int>> tab2( len );
    for (int i = 0; i < len; i++)
    {
        std::vector<int> tab3( i + 1, 0 );
        tab2[i] = tab3;
    }
    return find0(len, tab, tab2, 0, 0);
}

int main() {
    int tmp, len;
    std::cin >> len;
    std::vector<std::vector<int>> tab( len );
    for (int i = 0; i < len; i++)
    {
        std::vector<int> tab2( i + 1 );
        for (int j = 0; j <= i; j++)
        {
            std::cin >> tmp;
            tab2[j] = tmp;
        }
        tab[i] = tab2;
    }
    std::cout << find(len, tab) << "\n";
    for (int k = 0; k < len; k++)
    {
        for (int l = 0; l <= k; l++)
            std::cout << tab[k][l] << " ";
        std::cout << "\n";
    }
}

