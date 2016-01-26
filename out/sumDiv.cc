#include <iostream>
#include <vector>

void foo() {
    int a = 0;
    /* test */
    a++;
    /* test 2 */
}


void foo2() {
    
}


void foo3() {
    if (1 == 1)
    {
        
    }
}


int sumdiv(int n) {
    /* On désire renvoyer la somme des diviseurs */
    int out0 = 0;
    /* On déclare un entier qui contiendra la somme */
    for (int i = 1; i <= n; i ++)
    {
        /* La boucle : i est le diviseur potentiel*/
        if (n % i == 0)
        {
            /* Si i divise */
            out0 += i;
            /* On incrémente */
        }
        else
        {
            /* nop */
        }
    }
    return out0;
    /*On renvoie out*/
}


int main() {
    /* Programme principal */
    int n = 0;
    std::cin >> n >> std::noskipws;
    /* Lecture de l'entier */
    std::cout << sumdiv(n);
}

