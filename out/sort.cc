#include <iostream>
#include <vector>
std::vector<int> * copytab(std::vector<int> * tab, int len){
  std::vector<int> *o = new std::vector<int>( len );
  for (int i = 0 ; i < len; i++)
    o->at(i) = tab->at(i);
  return o;
}

void bubblesort(std::vector<int> * tab, int len){
  for (int i = 0 ; i < len; i++)
    for (int j = i + 1 ; j < len; j++)
      if (tab->at(i) > tab->at(j))
  {
    int tmp = tab->at(i);
    tab->at(i) = tab->at(j);
    tab->at(j) = tmp;
  }
}

void qsort0(std::vector<int> * tab, int len, int i, int j){
  if (i < j)
  {
    int i0 = i;
    int j0 = j;
    /* pivot : tab[0] */
    while (i != j)
      if (tab->at(i) > tab->at(j))
    {
      if (i == j - 1)
      {
        /* on inverse simplement*/
        int tmp = tab->at(i);
        tab->at(i) = tab->at(j);
        tab->at(j) = tmp;
        i++;
      }
      else
      {
        /* on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] */
        int tmp = tab->at(i);
        tab->at(i) = tab->at(j);
        tab->at(j) = tab->at(i + 1);
        tab->at(i + 1) = tmp;
        i++;
      }
    }
    else
      j --;
    qsort0(tab, len, i0, i - 1);
    qsort0(tab, len, i + 1, j0);
  }
}


int main(){
  int len = 2;
  std::cin >> len >> std::skipws;
  std::vector<int> *tab = new std::vector<int>( len );
  for (int i_ = 0 ; i_ < len; i_++)
  {
    int tmp = 0;
    std::cin >> tmp >> std::skipws;
    tab->at(i_) = tmp;
  }
  std::vector<int> * tab2 = copytab(tab, len);
  bubblesort(tab2, len);
  for (int i = 0 ; i < len; i++)
    std::cout << tab2->at(i) << " ";
  std::cout << "\n";
  std::vector<int> * tab3 = copytab(tab, len);
  qsort0(tab3, len, 0, len - 1);
  for (int i = 0 ; i < len; i++)
    std::cout << tab3->at(i) << " ";
  std::cout << "\n";
}

