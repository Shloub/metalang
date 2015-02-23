#include <iostream>
#include <vector>
/* lit un sudoku sur l'entrée standard */
std::vector<int> * read_sudoku(){
  int k;
  std::vector<int > *out0 = new std::vector<int>( 9 * 9 );
  for (int i = 0 ; i < 9 * 9; i++)
  {
    std::cin >> k >> std::skipws;
    out0->at(i) = k;
  }
  return out0;
}

/* affiche un sudoku */
void print_sudoku(std::vector<int> * sudoku0){
  for (int y = 0 ; y <= 8; y ++)
  {
    for (int x = 0 ; x <= 8; x ++)
    {
      std::cout << sudoku0->at(x + y * 9) << " ";
      if ((x % 3) == 2)
        std::cout << " ";
    }
    std::cout << "\n";
    if ((y % 3) == 2)
      std::cout << "\n";
  }
  std::cout << "\n";
}

/* dit si les variables sont toutes différentes */
/* dit si les variables sont toutes différentes */
/* dit si le sudoku est terminé de remplir */
bool sudoku_done(std::vector<int> * s){
  for (int i = 0 ; i <= 80; i ++)
    if (s->at(i) == 0)
    return false;
  return true;
}

/* dit si il y a une erreur dans le sudoku */
/* résout le sudoku*/
bool solve(std::vector<int> * sudoku0){
  if (false || (sudoku0->at(0) != 0 && sudoku0->at(0) == sudoku0->at(9)) || (sudoku0->at(0) !=
                                                                              0 &&
                                                                              sudoku0->at(0) ==
                                                                              sudoku0->at(18)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(18)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(27)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(27)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(27)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(36)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(36)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(36)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(36)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(45)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(45)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(45)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(45)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(45)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(54)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(54)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(54)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(54)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(54)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(54)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(63)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(63)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(63)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(63)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(63)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(63)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(63)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(10)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(19)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(19)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(28)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(28)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(28)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(37)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(37)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(37)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(37)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(55)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(55)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(55)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(55)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(55)) || (sudoku0->at(46) !=
                                                                                0 &&
                                                                                sudoku0->at(46) ==
                                                                                sudoku0->at(55)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(64)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(64)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(64)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(64)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(64)) || (sudoku0->at(46) !=
                                                                                0 &&
                                                                                sudoku0->at(46) ==
                                                                                sudoku0->at(64)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(64)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(46) !=
                                                                                0 &&
                                                                                sudoku0->at(46) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(64) !=
                                                                                0 &&
                                                                                sudoku0->at(64) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(11)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(20)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(20)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(29)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(29)) || (sudoku0->at(20) !=
                                                                                0 &&
                                                                                sudoku0->at(20) ==
                                                                                sudoku0->at(29)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(38)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(38)) || (sudoku0->at(20) !=
                                                                                0 &&
                                                                                sudoku0->at(20) ==
                                                                                sudoku0->at(38)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(38)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(20) !=
                                                                                0 &&
                                                                                sudoku0->at(20) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(56)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(56)) || (sudoku0->at(20) !=
                                                                                0 &&
                                                                                sudoku0->at(20) ==
                                                                                sudoku0->at(56)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(56)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(56)) || (sudoku0->at(47) !=
                                                                                0 &&
                                                                                sudoku0->at(47) ==
                                                                                sudoku0->at(56)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(20) !=
                                                                                0 &&
                                                                                sudoku0->at(20) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(47) !=
                                                                                0 &&
                                                                                sudoku0->at(47) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(20) !=
                                                                                0 &&
                                                                                sudoku0->at(20) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(47) !=
                                                                                0 &&
                                                                                sudoku0->at(47) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(65) !=
                                                                                0 &&
                                                                                sudoku0->at(65) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(12)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(21)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(21)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(30)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(30)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(30)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(39)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(39)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(39)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(39)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(57)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(57)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(57)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(57)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(57)) || (sudoku0->at(48) !=
                                                                                0 &&
                                                                                sudoku0->at(48) ==
                                                                                sudoku0->at(57)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(48) !=
                                                                                0 &&
                                                                                sudoku0->at(48) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(48) !=
                                                                                0 &&
                                                                                sudoku0->at(48) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(66) !=
                                                                                0 &&
                                                                                sudoku0->at(66) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(13)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(31)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(31)) || (sudoku0->at(22) !=
                                                                                0 &&
                                                                                sudoku0->at(22) ==
                                                                                sudoku0->at(31)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(40)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(40)) || (sudoku0->at(22) !=
                                                                                0 &&
                                                                                sudoku0->at(22) ==
                                                                                sudoku0->at(40)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(40)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(22) !=
                                                                                0 &&
                                                                                sudoku0->at(22) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(40) !=
                                                                                0 &&
                                                                                sudoku0->at(40) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(58)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(58)) || (sudoku0->at(22) !=
                                                                                0 &&
                                                                                sudoku0->at(22) ==
                                                                                sudoku0->at(58)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(58)) || (sudoku0->at(40) !=
                                                                                0 &&
                                                                                sudoku0->at(40) ==
                                                                                sudoku0->at(58)) || (sudoku0->at(49) !=
                                                                                0 &&
                                                                                sudoku0->at(49) ==
                                                                                sudoku0->at(58)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(22) !=
                                                                                0 &&
                                                                                sudoku0->at(22) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(40) !=
                                                                                0 &&
                                                                                sudoku0->at(40) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(49) !=
                                                                                0 &&
                                                                                sudoku0->at(49) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(22) !=
                                                                                0 &&
                                                                                sudoku0->at(22) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(40) !=
                                                                                0 &&
                                                                                sudoku0->at(40) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(49) !=
                                                                                0 &&
                                                                                sudoku0->at(49) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(67) !=
                                                                                0 &&
                                                                                sudoku0->at(67) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(14)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(32)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(32)) || (sudoku0->at(23) !=
                                                                                0 &&
                                                                                sudoku0->at(23) ==
                                                                                sudoku0->at(32)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(23) !=
                                                                                0 &&
                                                                                sudoku0->at(23) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(23) !=
                                                                                0 &&
                                                                                sudoku0->at(23) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(41) !=
                                                                                0 &&
                                                                                sudoku0->at(41) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(23) !=
                                                                                0 &&
                                                                                sudoku0->at(23) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(41) !=
                                                                                0 &&
                                                                                sudoku0->at(41) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(50) !=
                                                                                0 &&
                                                                                sudoku0->at(50) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(23) !=
                                                                                0 &&
                                                                                sudoku0->at(23) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(41) !=
                                                                                0 &&
                                                                                sudoku0->at(41) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(50) !=
                                                                                0 &&
                                                                                sudoku0->at(50) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(59) !=
                                                                                0 &&
                                                                                sudoku0->at(59) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(23) !=
                                                                                0 &&
                                                                                sudoku0->at(23) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(41) !=
                                                                                0 &&
                                                                                sudoku0->at(41) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(50) !=
                                                                                0 &&
                                                                                sudoku0->at(50) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(59) !=
                                                                                0 &&
                                                                                sudoku0->at(59) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(68) !=
                                                                                0 &&
                                                                                sudoku0->at(68) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(15)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(33)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(33)) || (sudoku0->at(24) !=
                                                                                0 &&
                                                                                sudoku0->at(24) ==
                                                                                sudoku0->at(33)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(24) !=
                                                                                0 &&
                                                                                sudoku0->at(24) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(24) !=
                                                                                0 &&
                                                                                sudoku0->at(24) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(42) !=
                                                                                0 &&
                                                                                sudoku0->at(42) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(60)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(60)) || (sudoku0->at(24) !=
                                                                                0 &&
                                                                                sudoku0->at(24) ==
                                                                                sudoku0->at(60)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(60)) || (sudoku0->at(42) !=
                                                                                0 &&
                                                                                sudoku0->at(42) ==
                                                                                sudoku0->at(60)) || (sudoku0->at(51) !=
                                                                                0 &&
                                                                                sudoku0->at(51) ==
                                                                                sudoku0->at(60)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(24) !=
                                                                                0 &&
                                                                                sudoku0->at(24) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(42) !=
                                                                                0 &&
                                                                                sudoku0->at(42) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(51) !=
                                                                                0 &&
                                                                                sudoku0->at(51) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(60) !=
                                                                                0 &&
                                                                                sudoku0->at(60) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(24) !=
                                                                                0 &&
                                                                                sudoku0->at(24) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(42) !=
                                                                                0 &&
                                                                                sudoku0->at(42) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(51) !=
                                                                                0 &&
                                                                                sudoku0->at(51) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(60) !=
                                                                                0 &&
                                                                                sudoku0->at(60) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(69) !=
                                                                                0 &&
                                                                                sudoku0->at(69) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(16)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(16) !=
                                                                                0 &&
                                                                                sudoku0->at(16) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(34)) || (sudoku0->at(16) !=
                                                                                0 &&
                                                                                sudoku0->at(16) ==
                                                                                sudoku0->at(34)) || (sudoku0->at(25) !=
                                                                                0 &&
                                                                                sudoku0->at(25) ==
                                                                                sudoku0->at(34)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(16) !=
                                                                                0 &&
                                                                                sudoku0->at(16) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(25) !=
                                                                                0 &&
                                                                                sudoku0->at(25) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(16) !=
                                                                                0 &&
                                                                                sudoku0->at(16) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(25) !=
                                                                                0 &&
                                                                                sudoku0->at(25) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(43) !=
                                                                                0 &&
                                                                                sudoku0->at(43) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(16) !=
                                                                                0 &&
                                                                                sudoku0->at(16) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(25) !=
                                                                                0 &&
                                                                                sudoku0->at(25) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(43) !=
                                                                                0 &&
                                                                                sudoku0->at(43) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(52) !=
                                                                                0 &&
                                                                                sudoku0->at(52) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(16) !=
                                                                                0 &&
                                                                                sudoku0->at(16) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(25) !=
                                                                                0 &&
                                                                                sudoku0->at(25) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(43) !=
                                                                                0 &&
                                                                                sudoku0->at(43) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(52) !=
                                                                                0 &&
                                                                                sudoku0->at(52) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(61) !=
                                                                                0 &&
                                                                                sudoku0->at(61) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(16) !=
                                                                                0 &&
                                                                                sudoku0->at(16) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(25) !=
                                                                                0 &&
                                                                                sudoku0->at(25) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(43) !=
                                                                                0 &&
                                                                                sudoku0->at(43) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(52) !=
                                                                                0 &&
                                                                                sudoku0->at(52) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(61) !=
                                                                                0 &&
                                                                                sudoku0->at(61) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(70) !=
                                                                                0 &&
                                                                                sudoku0->at(70) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(17) !=
                                                                                0 &&
                                                                                sudoku0->at(17) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(17) !=
                                                                                0 &&
                                                                                sudoku0->at(17) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(26) !=
                                                                                0 &&
                                                                                sudoku0->at(26) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(17) !=
                                                                                0 &&
                                                                                sudoku0->at(17) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(26) !=
                                                                                0 &&
                                                                                sudoku0->at(26) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(35) !=
                                                                                0 &&
                                                                                sudoku0->at(35) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(17) !=
                                                                                0 &&
                                                                                sudoku0->at(17) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(26) !=
                                                                                0 &&
                                                                                sudoku0->at(26) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(35) !=
                                                                                0 &&
                                                                                sudoku0->at(35) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(44) !=
                                                                                0 &&
                                                                                sudoku0->at(44) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(17) !=
                                                                                0 &&
                                                                                sudoku0->at(17) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(26) !=
                                                                                0 &&
                                                                                sudoku0->at(26) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(35) !=
                                                                                0 &&
                                                                                sudoku0->at(35) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(44) !=
                                                                                0 &&
                                                                                sudoku0->at(44) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(53) !=
                                                                                0 &&
                                                                                sudoku0->at(53) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(17) !=
                                                                                0 &&
                                                                                sudoku0->at(17) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(26) !=
                                                                                0 &&
                                                                                sudoku0->at(26) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(35) !=
                                                                                0 &&
                                                                                sudoku0->at(35) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(44) !=
                                                                                0 &&
                                                                                sudoku0->at(44) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(53) !=
                                                                                0 &&
                                                                                sudoku0->at(53) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(62) !=
                                                                                0 &&
                                                                                sudoku0->at(62) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(17) !=
                                                                                0 &&
                                                                                sudoku0->at(17) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(26) !=
                                                                                0 &&
                                                                                sudoku0->at(26) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(35) !=
                                                                                0 &&
                                                                                sudoku0->at(35) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(44) !=
                                                                                0 &&
                                                                                sudoku0->at(44) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(53) !=
                                                                                0 &&
                                                                                sudoku0->at(53) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(62) !=
                                                                                0 &&
                                                                                sudoku0->at(62) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(71) !=
                                                                                0 &&
                                                                                sudoku0->at(71) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(1)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(2)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(2)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(3)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(3)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(3)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(4)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(4)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(4)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(4)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(5)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(5)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(5)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(5)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(5)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(6)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(6)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(6)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(6)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(6)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(6)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(7)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(7)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(7)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(7)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(7)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(7)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(7)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(8)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(8)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(8)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(8)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(8)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(8)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(8)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(8)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(10)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(11)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(11)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(12)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(12)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(12)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(13)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(13)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(13)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(13)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(14)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(14)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(14)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(14)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(14)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(15)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(15)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(15)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(15)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(15)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(15)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(16)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(16)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(16)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(16)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(16)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(16)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(16)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(16) !=
                                                                                0 &&
                                                                                sudoku0->at(16) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(19)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(20)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(20)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(21)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(21)) || (sudoku0->at(20) !=
                                                                                0 &&
                                                                                sudoku0->at(20) ==
                                                                                sudoku0->at(21)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(20) !=
                                                                                0 &&
                                                                                sudoku0->at(20) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(20) !=
                                                                                0 &&
                                                                                sudoku0->at(20) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(22) !=
                                                                                0 &&
                                                                                sudoku0->at(22) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(20) !=
                                                                                0 &&
                                                                                sudoku0->at(20) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(22) !=
                                                                                0 &&
                                                                                sudoku0->at(22) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(23) !=
                                                                                0 &&
                                                                                sudoku0->at(23) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(20) !=
                                                                                0 &&
                                                                                sudoku0->at(20) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(22) !=
                                                                                0 &&
                                                                                sudoku0->at(22) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(23) !=
                                                                                0 &&
                                                                                sudoku0->at(23) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(24) !=
                                                                                0 &&
                                                                                sudoku0->at(24) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(20) !=
                                                                                0 &&
                                                                                sudoku0->at(20) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(22) !=
                                                                                0 &&
                                                                                sudoku0->at(22) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(23) !=
                                                                                0 &&
                                                                                sudoku0->at(23) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(24) !=
                                                                                0 &&
                                                                                sudoku0->at(24) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(25) !=
                                                                                0 &&
                                                                                sudoku0->at(25) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(28)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(29)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(29)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(30)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(30)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(30)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(31)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(31)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(31)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(31)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(32)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(32)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(32)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(32)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(32)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(33)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(33)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(33)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(33)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(33)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(33)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(34)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(34)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(34)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(34)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(34)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(34)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(34)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(37)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(38)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(38)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(39)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(39)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(39)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(40)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(40)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(40)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(40)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(40) !=
                                                                                0 &&
                                                                                sudoku0->at(40) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(40) !=
                                                                                0 &&
                                                                                sudoku0->at(40) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(41) !=
                                                                                0 &&
                                                                                sudoku0->at(41) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(40) !=
                                                                                0 &&
                                                                                sudoku0->at(40) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(41) !=
                                                                                0 &&
                                                                                sudoku0->at(41) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(42) !=
                                                                                0 &&
                                                                                sudoku0->at(42) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(40) !=
                                                                                0 &&
                                                                                sudoku0->at(40) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(41) !=
                                                                                0 &&
                                                                                sudoku0->at(41) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(42) !=
                                                                                0 &&
                                                                                sudoku0->at(42) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(43) !=
                                                                                0 &&
                                                                                sudoku0->at(43) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(46) !=
                                                                                0 &&
                                                                                sudoku0->at(46) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(46) !=
                                                                                0 &&
                                                                                sudoku0->at(46) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(47) !=
                                                                                0 &&
                                                                                sudoku0->at(47) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(46) !=
                                                                                0 &&
                                                                                sudoku0->at(46) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(47) !=
                                                                                0 &&
                                                                                sudoku0->at(47) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(48) !=
                                                                                0 &&
                                                                                sudoku0->at(48) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(46) !=
                                                                                0 &&
                                                                                sudoku0->at(46) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(47) !=
                                                                                0 &&
                                                                                sudoku0->at(47) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(48) !=
                                                                                0 &&
                                                                                sudoku0->at(48) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(49) !=
                                                                                0 &&
                                                                                sudoku0->at(49) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(46) !=
                                                                                0 &&
                                                                                sudoku0->at(46) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(47) !=
                                                                                0 &&
                                                                                sudoku0->at(47) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(48) !=
                                                                                0 &&
                                                                                sudoku0->at(48) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(49) !=
                                                                                0 &&
                                                                                sudoku0->at(49) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(50) !=
                                                                                0 &&
                                                                                sudoku0->at(50) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(46) !=
                                                                                0 &&
                                                                                sudoku0->at(46) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(47) !=
                                                                                0 &&
                                                                                sudoku0->at(47) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(48) !=
                                                                                0 &&
                                                                                sudoku0->at(48) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(49) !=
                                                                                0 &&
                                                                                sudoku0->at(49) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(50) !=
                                                                                0 &&
                                                                                sudoku0->at(50) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(51) !=
                                                                                0 &&
                                                                                sudoku0->at(51) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(46) !=
                                                                                0 &&
                                                                                sudoku0->at(46) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(47) !=
                                                                                0 &&
                                                                                sudoku0->at(47) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(48) !=
                                                                                0 &&
                                                                                sudoku0->at(48) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(49) !=
                                                                                0 &&
                                                                                sudoku0->at(49) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(50) !=
                                                                                0 &&
                                                                                sudoku0->at(50) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(51) !=
                                                                                0 &&
                                                                                sudoku0->at(51) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(52) !=
                                                                                0 &&
                                                                                sudoku0->at(52) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(55)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(56)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(56)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(57)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(57)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(57)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(58)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(58)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(58)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(58)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(60)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(60)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(60)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(60)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(60)) || (sudoku0->at(59) !=
                                                                                0 &&
                                                                                sudoku0->at(59) ==
                                                                                sudoku0->at(60)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(59) !=
                                                                                0 &&
                                                                                sudoku0->at(59) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(60) !=
                                                                                0 &&
                                                                                sudoku0->at(60) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(59) !=
                                                                                0 &&
                                                                                sudoku0->at(59) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(60) !=
                                                                                0 &&
                                                                                sudoku0->at(60) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(61) !=
                                                                                0 &&
                                                                                sudoku0->at(61) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(64)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(64) !=
                                                                                0 &&
                                                                                sudoku0->at(64) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(64) !=
                                                                                0 &&
                                                                                sudoku0->at(64) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(65) !=
                                                                                0 &&
                                                                                sudoku0->at(65) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(64) !=
                                                                                0 &&
                                                                                sudoku0->at(64) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(65) !=
                                                                                0 &&
                                                                                sudoku0->at(65) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(66) !=
                                                                                0 &&
                                                                                sudoku0->at(66) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(64) !=
                                                                                0 &&
                                                                                sudoku0->at(64) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(65) !=
                                                                                0 &&
                                                                                sudoku0->at(65) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(66) !=
                                                                                0 &&
                                                                                sudoku0->at(66) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(67) !=
                                                                                0 &&
                                                                                sudoku0->at(67) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(64) !=
                                                                                0 &&
                                                                                sudoku0->at(64) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(65) !=
                                                                                0 &&
                                                                                sudoku0->at(65) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(66) !=
                                                                                0 &&
                                                                                sudoku0->at(66) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(67) !=
                                                                                0 &&
                                                                                sudoku0->at(67) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(68) !=
                                                                                0 &&
                                                                                sudoku0->at(68) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(64) !=
                                                                                0 &&
                                                                                sudoku0->at(64) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(65) !=
                                                                                0 &&
                                                                                sudoku0->at(65) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(66) !=
                                                                                0 &&
                                                                                sudoku0->at(66) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(67) !=
                                                                                0 &&
                                                                                sudoku0->at(67) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(68) !=
                                                                                0 &&
                                                                                sudoku0->at(68) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(69) !=
                                                                                0 &&
                                                                                sudoku0->at(69) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(64) !=
                                                                                0 &&
                                                                                sudoku0->at(64) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(65) !=
                                                                                0 &&
                                                                                sudoku0->at(65) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(66) !=
                                                                                0 &&
                                                                                sudoku0->at(66) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(67) !=
                                                                                0 &&
                                                                                sudoku0->at(67) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(68) !=
                                                                                0 &&
                                                                                sudoku0->at(68) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(69) !=
                                                                                0 &&
                                                                                sudoku0->at(69) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(70) !=
                                                                                0 &&
                                                                                sudoku0->at(70) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(72) !=
                                                                                0 &&
                                                                                sudoku0->at(72) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(72) !=
                                                                                0 &&
                                                                                sudoku0->at(72) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(73) !=
                                                                                0 &&
                                                                                sudoku0->at(73) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(72) !=
                                                                                0 &&
                                                                                sudoku0->at(72) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(73) !=
                                                                                0 &&
                                                                                sudoku0->at(73) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(74) !=
                                                                                0 &&
                                                                                sudoku0->at(74) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(72) !=
                                                                                0 &&
                                                                                sudoku0->at(72) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(73) !=
                                                                                0 &&
                                                                                sudoku0->at(73) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(74) !=
                                                                                0 &&
                                                                                sudoku0->at(74) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(75) !=
                                                                                0 &&
                                                                                sudoku0->at(75) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(72) !=
                                                                                0 &&
                                                                                sudoku0->at(72) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(73) !=
                                                                                0 &&
                                                                                sudoku0->at(73) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(74) !=
                                                                                0 &&
                                                                                sudoku0->at(74) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(75) !=
                                                                                0 &&
                                                                                sudoku0->at(75) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(76) !=
                                                                                0 &&
                                                                                sudoku0->at(76) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(72) !=
                                                                                0 &&
                                                                                sudoku0->at(72) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(73) !=
                                                                                0 &&
                                                                                sudoku0->at(73) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(74) !=
                                                                                0 &&
                                                                                sudoku0->at(74) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(75) !=
                                                                                0 &&
                                                                                sudoku0->at(75) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(76) !=
                                                                                0 &&
                                                                                sudoku0->at(76) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(77) !=
                                                                                0 &&
                                                                                sudoku0->at(77) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(72) !=
                                                                                0 &&
                                                                                sudoku0->at(72) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(73) !=
                                                                                0 &&
                                                                                sudoku0->at(73) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(74) !=
                                                                                0 &&
                                                                                sudoku0->at(74) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(75) !=
                                                                                0 &&
                                                                                sudoku0->at(75) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(76) !=
                                                                                0 &&
                                                                                sudoku0->at(76) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(77) !=
                                                                                0 &&
                                                                                sudoku0->at(77) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(78) !=
                                                                                0 &&
                                                                                sudoku0->at(78) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(72) !=
                                                                                0 &&
                                                                                sudoku0->at(72) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(73) !=
                                                                                0 &&
                                                                                sudoku0->at(73) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(74) !=
                                                                                0 &&
                                                                                sudoku0->at(74) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(75) !=
                                                                                0 &&
                                                                                sudoku0->at(75) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(76) !=
                                                                                0 &&
                                                                                sudoku0->at(76) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(77) !=
                                                                                0 &&
                                                                                sudoku0->at(77) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(78) !=
                                                                                0 &&
                                                                                sudoku0->at(78) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(79) !=
                                                                                0 &&
                                                                                sudoku0->at(79) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(1)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(2)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(2)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(9)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(9)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(9)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(10)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(10)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(10)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(10)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(11)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(11)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(11)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(11)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(11)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(18)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(18)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(18)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(18)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(18)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(18)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(19)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(19)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(19)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(19)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(19)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(19)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(19)) || (sudoku0->at(0) !=
                                                                                0 &&
                                                                                sudoku0->at(0) ==
                                                                                sudoku0->at(20)) || (sudoku0->at(1) !=
                                                                                0 &&
                                                                                sudoku0->at(1) ==
                                                                                sudoku0->at(20)) || (sudoku0->at(2) !=
                                                                                0 &&
                                                                                sudoku0->at(2) ==
                                                                                sudoku0->at(20)) || (sudoku0->at(9) !=
                                                                                0 &&
                                                                                sudoku0->at(9) ==
                                                                                sudoku0->at(20)) || (sudoku0->at(10) !=
                                                                                0 &&
                                                                                sudoku0->at(10) ==
                                                                                sudoku0->at(20)) || (sudoku0->at(11) !=
                                                                                0 &&
                                                                                sudoku0->at(11) ==
                                                                                sudoku0->at(20)) || (sudoku0->at(18) !=
                                                                                0 &&
                                                                                sudoku0->at(18) ==
                                                                                sudoku0->at(20)) || (sudoku0->at(19) !=
                                                                                0 &&
                                                                                sudoku0->at(19) ==
                                                                                sudoku0->at(20)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(28)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(29)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(29)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(36)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(36)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(36)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(37)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(37)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(37)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(37)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(38)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(38)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(38)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(38)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(38)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(45)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(45)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(45)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(45)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(45)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(45)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(46)) || (sudoku0->at(27) !=
                                                                                0 &&
                                                                                sudoku0->at(27) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(28) !=
                                                                                0 &&
                                                                                sudoku0->at(28) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(29) !=
                                                                                0 &&
                                                                                sudoku0->at(29) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(36) !=
                                                                                0 &&
                                                                                sudoku0->at(36) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(37) !=
                                                                                0 &&
                                                                                sudoku0->at(37) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(38) !=
                                                                                0 &&
                                                                                sudoku0->at(38) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(45) !=
                                                                                0 &&
                                                                                sudoku0->at(45) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(46) !=
                                                                                0 &&
                                                                                sudoku0->at(46) ==
                                                                                sudoku0->at(47)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(55)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(56)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(56)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(63)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(63)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(63)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(64)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(64)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(64)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(64)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(64) !=
                                                                                0 &&
                                                                                sudoku0->at(64) ==
                                                                                sudoku0->at(65)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(64) !=
                                                                                0 &&
                                                                                sudoku0->at(64) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(65) !=
                                                                                0 &&
                                                                                sudoku0->at(65) ==
                                                                                sudoku0->at(72)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(64) !=
                                                                                0 &&
                                                                                sudoku0->at(64) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(65) !=
                                                                                0 &&
                                                                                sudoku0->at(65) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(72) !=
                                                                                0 &&
                                                                                sudoku0->at(72) ==
                                                                                sudoku0->at(73)) || (sudoku0->at(54) !=
                                                                                0 &&
                                                                                sudoku0->at(54) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(55) !=
                                                                                0 &&
                                                                                sudoku0->at(55) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(56) !=
                                                                                0 &&
                                                                                sudoku0->at(56) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(63) !=
                                                                                0 &&
                                                                                sudoku0->at(63) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(64) !=
                                                                                0 &&
                                                                                sudoku0->at(64) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(65) !=
                                                                                0 &&
                                                                                sudoku0->at(65) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(72) !=
                                                                                0 &&
                                                                                sudoku0->at(72) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(73) !=
                                                                                0 &&
                                                                                sudoku0->at(73) ==
                                                                                sudoku0->at(74)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(4)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(5)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(5)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(12)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(12)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(12)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(13)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(13)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(13)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(13)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(14)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(14)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(14)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(14)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(14)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(21)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(21)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(21)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(21)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(21)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(21)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(22)) || (sudoku0->at(3) !=
                                                                                0 &&
                                                                                sudoku0->at(3) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(4) !=
                                                                                0 &&
                                                                                sudoku0->at(4) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(5) !=
                                                                                0 &&
                                                                                sudoku0->at(5) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(12) !=
                                                                                0 &&
                                                                                sudoku0->at(12) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(13) !=
                                                                                0 &&
                                                                                sudoku0->at(13) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(14) !=
                                                                                0 &&
                                                                                sudoku0->at(14) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(21) !=
                                                                                0 &&
                                                                                sudoku0->at(21) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(22) !=
                                                                                0 &&
                                                                                sudoku0->at(22) ==
                                                                                sudoku0->at(23)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(31)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(32)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(32)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(39)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(39)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(39)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(40)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(40)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(40)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(40)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(40) !=
                                                                                0 &&
                                                                                sudoku0->at(40) ==
                                                                                sudoku0->at(41)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(40) !=
                                                                                0 &&
                                                                                sudoku0->at(40) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(41) !=
                                                                                0 &&
                                                                                sudoku0->at(41) ==
                                                                                sudoku0->at(48)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(40) !=
                                                                                0 &&
                                                                                sudoku0->at(40) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(41) !=
                                                                                0 &&
                                                                                sudoku0->at(41) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(48) !=
                                                                                0 &&
                                                                                sudoku0->at(48) ==
                                                                                sudoku0->at(49)) || (sudoku0->at(30) !=
                                                                                0 &&
                                                                                sudoku0->at(30) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(31) !=
                                                                                0 &&
                                                                                sudoku0->at(31) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(32) !=
                                                                                0 &&
                                                                                sudoku0->at(32) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(39) !=
                                                                                0 &&
                                                                                sudoku0->at(39) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(40) !=
                                                                                0 &&
                                                                                sudoku0->at(40) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(41) !=
                                                                                0 &&
                                                                                sudoku0->at(41) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(48) !=
                                                                                0 &&
                                                                                sudoku0->at(48) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(49) !=
                                                                                0 &&
                                                                                sudoku0->at(49) ==
                                                                                sudoku0->at(50)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(58)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(59)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(59) !=
                                                                                0 &&
                                                                                sudoku0->at(59) ==
                                                                                sudoku0->at(66)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(59) !=
                                                                                0 &&
                                                                                sudoku0->at(59) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(66) !=
                                                                                0 &&
                                                                                sudoku0->at(66) ==
                                                                                sudoku0->at(67)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(59) !=
                                                                                0 &&
                                                                                sudoku0->at(59) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(66) !=
                                                                                0 &&
                                                                                sudoku0->at(66) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(67) !=
                                                                                0 &&
                                                                                sudoku0->at(67) ==
                                                                                sudoku0->at(68)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(59) !=
                                                                                0 &&
                                                                                sudoku0->at(59) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(66) !=
                                                                                0 &&
                                                                                sudoku0->at(66) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(67) !=
                                                                                0 &&
                                                                                sudoku0->at(67) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(68) !=
                                                                                0 &&
                                                                                sudoku0->at(68) ==
                                                                                sudoku0->at(75)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(59) !=
                                                                                0 &&
                                                                                sudoku0->at(59) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(66) !=
                                                                                0 &&
                                                                                sudoku0->at(66) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(67) !=
                                                                                0 &&
                                                                                sudoku0->at(67) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(68) !=
                                                                                0 &&
                                                                                sudoku0->at(68) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(75) !=
                                                                                0 &&
                                                                                sudoku0->at(75) ==
                                                                                sudoku0->at(76)) || (sudoku0->at(57) !=
                                                                                0 &&
                                                                                sudoku0->at(57) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(58) !=
                                                                                0 &&
                                                                                sudoku0->at(58) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(59) !=
                                                                                0 &&
                                                                                sudoku0->at(59) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(66) !=
                                                                                0 &&
                                                                                sudoku0->at(66) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(67) !=
                                                                                0 &&
                                                                                sudoku0->at(67) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(68) !=
                                                                                0 &&
                                                                                sudoku0->at(68) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(75) !=
                                                                                0 &&
                                                                                sudoku0->at(75) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(76) !=
                                                                                0 &&
                                                                                sudoku0->at(76) ==
                                                                                sudoku0->at(77)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(7)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(8)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(8)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(15)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(15)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(15)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(16)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(16)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(16)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(16)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(16) !=
                                                                                0 &&
                                                                                sudoku0->at(16) ==
                                                                                sudoku0->at(17)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(16) !=
                                                                                0 &&
                                                                                sudoku0->at(16) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(17) !=
                                                                                0 &&
                                                                                sudoku0->at(17) ==
                                                                                sudoku0->at(24)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(16) !=
                                                                                0 &&
                                                                                sudoku0->at(16) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(17) !=
                                                                                0 &&
                                                                                sudoku0->at(17) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(24) !=
                                                                                0 &&
                                                                                sudoku0->at(24) ==
                                                                                sudoku0->at(25)) || (sudoku0->at(6) !=
                                                                                0 &&
                                                                                sudoku0->at(6) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(7) !=
                                                                                0 &&
                                                                                sudoku0->at(7) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(8) !=
                                                                                0 &&
                                                                                sudoku0->at(8) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(15) !=
                                                                                0 &&
                                                                                sudoku0->at(15) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(16) !=
                                                                                0 &&
                                                                                sudoku0->at(16) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(17) !=
                                                                                0 &&
                                                                                sudoku0->at(17) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(24) !=
                                                                                0 &&
                                                                                sudoku0->at(24) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(25) !=
                                                                                0 &&
                                                                                sudoku0->at(25) ==
                                                                                sudoku0->at(26)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(34)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(35)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(35) !=
                                                                                0 &&
                                                                                sudoku0->at(35) ==
                                                                                sudoku0->at(42)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(35) !=
                                                                                0 &&
                                                                                sudoku0->at(35) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(42) !=
                                                                                0 &&
                                                                                sudoku0->at(42) ==
                                                                                sudoku0->at(43)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(35) !=
                                                                                0 &&
                                                                                sudoku0->at(35) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(42) !=
                                                                                0 &&
                                                                                sudoku0->at(42) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(43) !=
                                                                                0 &&
                                                                                sudoku0->at(43) ==
                                                                                sudoku0->at(44)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(35) !=
                                                                                0 &&
                                                                                sudoku0->at(35) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(42) !=
                                                                                0 &&
                                                                                sudoku0->at(42) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(43) !=
                                                                                0 &&
                                                                                sudoku0->at(43) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(44) !=
                                                                                0 &&
                                                                                sudoku0->at(44) ==
                                                                                sudoku0->at(51)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(35) !=
                                                                                0 &&
                                                                                sudoku0->at(35) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(42) !=
                                                                                0 &&
                                                                                sudoku0->at(42) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(43) !=
                                                                                0 &&
                                                                                sudoku0->at(43) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(44) !=
                                                                                0 &&
                                                                                sudoku0->at(44) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(51) !=
                                                                                0 &&
                                                                                sudoku0->at(51) ==
                                                                                sudoku0->at(52)) || (sudoku0->at(33) !=
                                                                                0 &&
                                                                                sudoku0->at(33) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(34) !=
                                                                                0 &&
                                                                                sudoku0->at(34) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(35) !=
                                                                                0 &&
                                                                                sudoku0->at(35) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(42) !=
                                                                                0 &&
                                                                                sudoku0->at(42) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(43) !=
                                                                                0 &&
                                                                                sudoku0->at(43) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(44) !=
                                                                                0 &&
                                                                                sudoku0->at(44) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(51) !=
                                                                                0 &&
                                                                                sudoku0->at(51) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(52) !=
                                                                                0 &&
                                                                                sudoku0->at(52) ==
                                                                                sudoku0->at(53)) || (sudoku0->at(60) !=
                                                                                0 &&
                                                                                sudoku0->at(60) ==
                                                                                sudoku0->at(61)) || (sudoku0->at(60) !=
                                                                                0 &&
                                                                                sudoku0->at(60) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(61) !=
                                                                                0 &&
                                                                                sudoku0->at(61) ==
                                                                                sudoku0->at(62)) || (sudoku0->at(60) !=
                                                                                0 &&
                                                                                sudoku0->at(60) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(61) !=
                                                                                0 &&
                                                                                sudoku0->at(61) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(62) !=
                                                                                0 &&
                                                                                sudoku0->at(62) ==
                                                                                sudoku0->at(69)) || (sudoku0->at(60) !=
                                                                                0 &&
                                                                                sudoku0->at(60) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(61) !=
                                                                                0 &&
                                                                                sudoku0->at(61) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(62) !=
                                                                                0 &&
                                                                                sudoku0->at(62) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(69) !=
                                                                                0 &&
                                                                                sudoku0->at(69) ==
                                                                                sudoku0->at(70)) || (sudoku0->at(60) !=
                                                                                0 &&
                                                                                sudoku0->at(60) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(61) !=
                                                                                0 &&
                                                                                sudoku0->at(61) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(62) !=
                                                                                0 &&
                                                                                sudoku0->at(62) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(69) !=
                                                                                0 &&
                                                                                sudoku0->at(69) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(70) !=
                                                                                0 &&
                                                                                sudoku0->at(70) ==
                                                                                sudoku0->at(71)) || (sudoku0->at(60) !=
                                                                                0 &&
                                                                                sudoku0->at(60) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(61) !=
                                                                                0 &&
                                                                                sudoku0->at(61) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(62) !=
                                                                                0 &&
                                                                                sudoku0->at(62) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(69) !=
                                                                                0 &&
                                                                                sudoku0->at(69) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(70) !=
                                                                                0 &&
                                                                                sudoku0->at(70) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(71) !=
                                                                                0 &&
                                                                                sudoku0->at(71) ==
                                                                                sudoku0->at(78)) || (sudoku0->at(60) !=
                                                                                0 &&
                                                                                sudoku0->at(60) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(61) !=
                                                                                0 &&
                                                                                sudoku0->at(61) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(62) !=
                                                                                0 &&
                                                                                sudoku0->at(62) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(69) !=
                                                                                0 &&
                                                                                sudoku0->at(69) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(70) !=
                                                                                0 &&
                                                                                sudoku0->at(70) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(71) !=
                                                                                0 &&
                                                                                sudoku0->at(71) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(78) !=
                                                                                0 &&
                                                                                sudoku0->at(78) ==
                                                                                sudoku0->at(79)) || (sudoku0->at(60) !=
                                                                                0 &&
                                                                                sudoku0->at(60) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(61) !=
                                                                                0 &&
                                                                                sudoku0->at(61) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(62) !=
                                                                                0 &&
                                                                                sudoku0->at(62) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(69) !=
                                                                                0 &&
                                                                                sudoku0->at(69) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(70) !=
                                                                                0 &&
                                                                                sudoku0->at(70) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(71) !=
                                                                                0 &&
                                                                                sudoku0->at(71) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(78) !=
                                                                                0 &&
                                                                                sudoku0->at(78) ==
                                                                                sudoku0->at(80)) || (sudoku0->at(79) !=
                                                                                0 &&
                                                                                sudoku0->at(79) ==
                                                                                sudoku0->at(80)))
    return false;
  if (sudoku_done(sudoku0))
    return true;
  for (int i = 0 ; i <= 80; i ++)
    if (sudoku0->at(i) == 0)
  {
    for (int p = 1 ; p <= 9; p ++)
    {
      sudoku0->at(i) = p;
      if (solve(sudoku0))
        return true;
    }
    sudoku0->at(i) = 0;
    return false;
  }
  return false;
}


int main(){
  std::vector<int> * sudoku0 = read_sudoku();
  print_sudoku(sudoku0);
  if (solve(sudoku0))
    print_sudoku(sudoku0);
  else
    std::cout << "no solution\n";
  return 0;
}

