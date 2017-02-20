import groovy.transform.Field
import java.util.*

//  lit un sudoku sur l'entrée standard 

int[] read_sudoku()
{
  int[] out0 = new int[9 * 9]
  for (int i = 0; i < 9 * 9; i++)
  {
      int k
      if (scanner.hasNext("^-")) {
        scanner.next("^-")
        k = scanner.nextInt()
      } else {
        k = scanner.nextInt()
      }
      scanner.findWithinHorizon("[\n\r ]*", 1)
      out0[i] = k
  }
  return out0
}

//  affiche un sudoku 

void print_sudoku(int[] sudoku0)
{
  for (int y = 0; y < 9; y++)
  {
      for (int x = 0; x < 9; x++)
      {
          System.out.printf("%d ", sudoku0[x + y * 9])
          if (x % 3 == 2)
              print(" ")
      }
      print("\n")
      if (y % 3 == 2)
          print("\n")
  }
  print("\n")
}

//  dit si les variables sont toutes différentes 

//  dit si les variables sont toutes différentes 

//  dit si le sudoku est terminé de remplir 

boolean sudoku_done(int[] s)
{
  for (int i = 0; i < 81; i++)
      if (s[i] == 0)
          return false
  return true
}

//  dit si il y a une erreur dans le sudoku 

boolean sudoku_error(int[] s)
{
  boolean out1 = false
  for (int x = 0; x < 9; x++)
      out1 = out1 || s[x] != 0 && s[x] == s[x + 9] || s[x] != 0 && s[x] == s[x + 9 * 2] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 2] || s[x] != 0 && s[x] == s[x + 9 * 3] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 3] || s[x + 9 * 2] != 0 && s[x + 9 * 2] == s[x + 9 * 3] || s[x] != 0 && s[x] == s[x + 9 * 4] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 4] || s[x + 9 * 2] != 0 && s[x + 9 * 2] == s[x + 9 * 4] || s[x + 9 * 3] != 0 && s[x + 9 * 3] == s[x + 9 * 4] || s[x] != 0 && s[x] == s[x + 9 * 5] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 5] || s[x + 9 * 2] != 0 && s[x + 9 * 2] == s[x + 9 * 5] || s[x + 9 * 3] != 0 && s[x + 9 * 3] == s[x + 9 * 5] || s[x + 9 * 4] != 0 && s[x + 9 * 4] == s[x + 9 * 5] || s[x] != 0 && s[x] == s[x + 9 * 6] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 6] || s[x + 9 * 2] != 0 && s[x + 9 * 2] == s[x + 9 * 6] || s[x + 9 * 3] != 0 && s[x + 9 * 3] == s[x + 9 * 6] || s[x + 9 * 4] != 0 && s[x + 9 * 4] == s[x + 9 * 6] || s[x + 9 * 5] != 0 && s[x + 9 * 5] == s[x + 9 * 6] || s[x] != 0 && s[x] == s[x + 9 * 7] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 7] || s[x + 9 * 2] != 0 && s[x + 9 * 2] == s[x + 9 * 7] || s[x + 9 * 3] != 0 && s[x + 9 * 3] == s[x + 9 * 7] || s[x + 9 * 4] != 0 && s[x + 9 * 4] == s[x + 9 * 7] || s[x + 9 * 5] != 0 && s[x + 9 * 5] == s[x + 9 * 7] || s[x + 9 * 6] != 0 && s[x + 9 * 6] == s[x + 9 * 7] || s[x] != 0 && s[x] == s[x + 9 * 8] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 8] || s[x + 9 * 2] != 0 && s[x + 9 * 2] == s[x + 9 * 8] || s[x + 9 * 3] != 0 && s[x + 9 * 3] == s[x + 9 * 8] || s[x + 9 * 4] != 0 && s[x + 9 * 4] == s[x + 9 * 8] || s[x + 9 * 5] != 0 && s[x + 9 * 5] == s[x + 9 * 8] || s[x + 9 * 6] != 0 && s[x + 9 * 6] == s[x + 9 * 8] || s[x + 9 * 7] != 0 && s[x + 9 * 7] == s[x + 9 * 8]
  boolean out2 = false
  for (int x = 0; x < 9; x++)
      out2 = out2 || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 1] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 2] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 2] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 3] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 3] || s[x * 9 + 2] != 0 && s[x * 9 + 2] == s[x * 9 + 3] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 4] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 4] || s[x * 9 + 2] != 0 && s[x * 9 + 2] == s[x * 9 + 4] || s[x * 9 + 3] != 0 && s[x * 9 + 3] == s[x * 9 + 4] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 5] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 5] || s[x * 9 + 2] != 0 && s[x * 9 + 2] == s[x * 9 + 5] || s[x * 9 + 3] != 0 && s[x * 9 + 3] == s[x * 9 + 5] || s[x * 9 + 4] != 0 && s[x * 9 + 4] == s[x * 9 + 5] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 6] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 6] || s[x * 9 + 2] != 0 && s[x * 9 + 2] == s[x * 9 + 6] || s[x * 9 + 3] != 0 && s[x * 9 + 3] == s[x * 9 + 6] || s[x * 9 + 4] != 0 && s[x * 9 + 4] == s[x * 9 + 6] || s[x * 9 + 5] != 0 && s[x * 9 + 5] == s[x * 9 + 6] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 7] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 7] || s[x * 9 + 2] != 0 && s[x * 9 + 2] == s[x * 9 + 7] || s[x * 9 + 3] != 0 && s[x * 9 + 3] == s[x * 9 + 7] || s[x * 9 + 4] != 0 && s[x * 9 + 4] == s[x * 9 + 7] || s[x * 9 + 5] != 0 && s[x * 9 + 5] == s[x * 9 + 7] || s[x * 9 + 6] != 0 && s[x * 9 + 6] == s[x * 9 + 7] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 8] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 8] || s[x * 9 + 2] != 0 && s[x * 9 + 2] == s[x * 9 + 8] || s[x * 9 + 3] != 0 && s[x * 9 + 3] == s[x * 9 + 8] || s[x * 9 + 4] != 0 && s[x * 9 + 4] == s[x * 9 + 8] || s[x * 9 + 5] != 0 && s[x * 9 + 5] == s[x * 9 + 8] || s[x * 9 + 6] != 0 && s[x * 9 + 6] == s[x * 9 + 8] || s[x * 9 + 7] != 0 && s[x * 9 + 7] == s[x * 9 + 8]
  boolean out3 = false
  for (int x = 0; x < 9; x++)
      out3 = out3 || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] == s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] == s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] == s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] == s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] == s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 1] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] == s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 1] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] == s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 1] || s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] != 0 && s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 1] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 2] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] == s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 2] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] == s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 2] || s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] != 0 && s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 2] || s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 1] != 0 && s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 1] == s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 2] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3] || s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] != 0 && s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3] || s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 1] != 0 && s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 1] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3] || s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 2] != 0 && s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 2] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 1] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 1] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 1] || s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] != 0 && s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 1] || s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 1] != 0 && s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 1] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 1] || s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 2] != 0 && s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 2] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 1] || s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3] != 0 && s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 1] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 2] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 1] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 2] || s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] != 0 && s[(x % 3) * 3 * 9 + x.intdiv(3) * 3 + 2] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 2] || s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] != 0 && s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 2] || s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 1] != 0 && s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 1] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 2] || s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 2] != 0 && s[((x % 3) * 3 + 1) * 9 + x.intdiv(3) * 3 + 2] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 2] || s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3] != 0 && s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 2] || s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 1] != 0 && s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 1] == s[((x % 3) * 3 + 2) * 9 + x.intdiv(3) * 3 + 2]
  return out1 || out2 || out3
}

//  résout le sudoku

boolean solve(int[] sudoku0)
{
  if (sudoku_error(sudoku0))
      return false
  if (sudoku_done(sudoku0))
      return true
  for (int i = 0; i < 81; i++)
      if (sudoku0[i] == 0)
      {
          for (int p = 1; p < 10; p++)
          {
              sudoku0[i] = p
              if (solve(sudoku0))
                  return true
          }
          sudoku0[i] = 0
          return false
      }
  return false
}


@Field Scanner scanner = new Scanner(System.in)
int[] sudoku0 = read_sudoku()
print_sudoku(sudoku0)
if (solve(sudoku0))
    print_sudoku(sudoku0)
else
    print("no solution\n")

