using System;

public class sudoku
{
static bool eof;
static String buffer;
public static char readChar_(){
  if (buffer == null){
    buffer = Console.ReadLine();
  }
  if (buffer.Length == 0){
    String tmp = Console.ReadLine();
    eof = tmp == null;
    buffer = "\n"+tmp;
  }
  char c = buffer[0];
  return c;
}
public static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
}
public static void stdin_sep(){
  do{
    if (eof) return;
    char c = readChar_();
    if (c == ' ' || c == '\n' || c == '\t' || c == '\r'){
      consommeChar();
    }else{
      return;
    }
  } while(true);
}
public static int readInt(){
  int i = 0;
  char s = readChar_();
  int sign = 1;
  if (s == '-'){
    sign = -1;
    consommeChar();
  }
  do{
    char c = readChar_();
    if (c <= '9' && c >= '0'){
      i = i * 10 + c - '0';
      consommeChar();
    }else{
      return i * sign;
    }
  } while(true);
} 
  /* lit un sudoku sur l'entrée standard */
  public static int[] read_sudoku()
  {
    int[] out0 = new int[9 * 9];
    for (int i = 0 ; i < 9 * 9; i++)
    {
      int k = readInt();
      stdin_sep();
      out0[i] = k;
    }
    return out0;
  }
  
  /* affiche un sudoku */
  public static void print_sudoku(int[] sudoku0)
  {
    for (int y = 0 ; y <= 8; y ++)
    {
      for (int x = 0 ; x <= 8; x ++)
      {
        Console.Write("" + sudoku0[x + y * 9] + " ");
        if ((x % 3) == 2)
          Console.Write(" ");
      }
      Console.Write("\n");
      if ((y % 3) == 2)
        Console.Write("\n");
    }
    Console.Write("\n");
  }
  
  /* dit si les variables sont toutes différentes */
  /* dit si les variables sont toutes différentes */
  /* dit si le sudoku est terminé de remplir */
  public static bool sudoku_done(int[] s)
  {
    for (int i = 0 ; i <= 80; i ++)
      if (s[i] == 0)
      return false;
    return true;
  }
  
  /* dit si il y a une erreur dans le sudoku */
  /* résout le sudoku*/
  public static bool solve(int[] sudoku0)
  {
    if (false || (sudoku0[0] != 0 && sudoku0[0] == sudoku0[9]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[18]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[18]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[27]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[27]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[27]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[36]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[36]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[36]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[36]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[45]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[45]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[45]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[45]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[45]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[54]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[54]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[54]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[54]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[54]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[54]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[63]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[63]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[63]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[63]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[63]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[63]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[63]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[72]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[72]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[72]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[72]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[72]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[72]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[72]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[72]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[10]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[19]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[19]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[28]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[28]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[28]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[37]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[37]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[37]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[37]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[46]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[46]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[46]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[46]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[46]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[55]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[55]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[55]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[55]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[55]) || (sudoku0[46] !=
                                                                    0 &&
                                                                    sudoku0[46] ==
                                                                    sudoku0[55]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[64]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[64]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[64]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[64]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[64]) || (sudoku0[46] !=
                                                                    0 &&
                                                                    sudoku0[46] ==
                                                                    sudoku0[64]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[64]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[73]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[73]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[73]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[73]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[73]) || (sudoku0[46] !=
                                                                    0 &&
                                                                    sudoku0[46] ==
                                                                    sudoku0[73]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[73]) || (sudoku0[64] !=
                                                                    0 &&
                                                                    sudoku0[64] ==
                                                                    sudoku0[73]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[11]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[20]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[20]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[29]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[29]) || (sudoku0[20] !=
                                                                    0 &&
                                                                    sudoku0[20] ==
                                                                    sudoku0[29]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[38]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[38]) || (sudoku0[20] !=
                                                                    0 &&
                                                                    sudoku0[20] ==
                                                                    sudoku0[38]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[38]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[47]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[47]) || (sudoku0[20] !=
                                                                    0 &&
                                                                    sudoku0[20] ==
                                                                    sudoku0[47]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[47]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[47]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[56]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[56]) || (sudoku0[20] !=
                                                                    0 &&
                                                                    sudoku0[20] ==
                                                                    sudoku0[56]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[56]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[56]) || (sudoku0[47] !=
                                                                    0 &&
                                                                    sudoku0[47] ==
                                                                    sudoku0[56]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[65]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[65]) || (sudoku0[20] !=
                                                                    0 &&
                                                                    sudoku0[20] ==
                                                                    sudoku0[65]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[65]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[65]) || (sudoku0[47] !=
                                                                    0 &&
                                                                    sudoku0[47] ==
                                                                    sudoku0[65]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[65]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[74]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[74]) || (sudoku0[20] !=
                                                                    0 &&
                                                                    sudoku0[20] ==
                                                                    sudoku0[74]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[74]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[74]) || (sudoku0[47] !=
                                                                    0 &&
                                                                    sudoku0[47] ==
                                                                    sudoku0[74]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[74]) || (sudoku0[65] !=
                                                                    0 &&
                                                                    sudoku0[65] ==
                                                                    sudoku0[74]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[12]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[21]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[21]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[30]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[30]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[30]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[39]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[39]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[39]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[39]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[48]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[48]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[48]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[48]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[48]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[57]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[57]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[57]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[57]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[57]) || (sudoku0[48] !=
                                                                    0 &&
                                                                    sudoku0[48] ==
                                                                    sudoku0[57]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[66]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[66]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[66]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[66]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[66]) || (sudoku0[48] !=
                                                                    0 &&
                                                                    sudoku0[48] ==
                                                                    sudoku0[66]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[66]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[75]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[75]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[75]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[75]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[75]) || (sudoku0[48] !=
                                                                    0 &&
                                                                    sudoku0[48] ==
                                                                    sudoku0[75]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[75]) || (sudoku0[66] !=
                                                                    0 &&
                                                                    sudoku0[66] ==
                                                                    sudoku0[75]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[13]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[22]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[22]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[31]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[31]) || (sudoku0[22] !=
                                                                    0 &&
                                                                    sudoku0[22] ==
                                                                    sudoku0[31]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[40]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[40]) || (sudoku0[22] !=
                                                                    0 &&
                                                                    sudoku0[22] ==
                                                                    sudoku0[40]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[40]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[49]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[49]) || (sudoku0[22] !=
                                                                    0 &&
                                                                    sudoku0[22] ==
                                                                    sudoku0[49]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[49]) || (sudoku0[40] !=
                                                                    0 &&
                                                                    sudoku0[40] ==
                                                                    sudoku0[49]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[58]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[58]) || (sudoku0[22] !=
                                                                    0 &&
                                                                    sudoku0[22] ==
                                                                    sudoku0[58]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[58]) || (sudoku0[40] !=
                                                                    0 &&
                                                                    sudoku0[40] ==
                                                                    sudoku0[58]) || (sudoku0[49] !=
                                                                    0 &&
                                                                    sudoku0[49] ==
                                                                    sudoku0[58]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[67]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[67]) || (sudoku0[22] !=
                                                                    0 &&
                                                                    sudoku0[22] ==
                                                                    sudoku0[67]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[67]) || (sudoku0[40] !=
                                                                    0 &&
                                                                    sudoku0[40] ==
                                                                    sudoku0[67]) || (sudoku0[49] !=
                                                                    0 &&
                                                                    sudoku0[49] ==
                                                                    sudoku0[67]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[67]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[76]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[76]) || (sudoku0[22] !=
                                                                    0 &&
                                                                    sudoku0[22] ==
                                                                    sudoku0[76]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[76]) || (sudoku0[40] !=
                                                                    0 &&
                                                                    sudoku0[40] ==
                                                                    sudoku0[76]) || (sudoku0[49] !=
                                                                    0 &&
                                                                    sudoku0[49] ==
                                                                    sudoku0[76]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[76]) || (sudoku0[67] !=
                                                                    0 &&
                                                                    sudoku0[67] ==
                                                                    sudoku0[76]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[14]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[23]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[23]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[32]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[32]) || (sudoku0[23] !=
                                                                    0 &&
                                                                    sudoku0[23] ==
                                                                    sudoku0[32]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[41]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[41]) || (sudoku0[23] !=
                                                                    0 &&
                                                                    sudoku0[23] ==
                                                                    sudoku0[41]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[41]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[50]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[50]) || (sudoku0[23] !=
                                                                    0 &&
                                                                    sudoku0[23] ==
                                                                    sudoku0[50]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[50]) || (sudoku0[41] !=
                                                                    0 &&
                                                                    sudoku0[41] ==
                                                                    sudoku0[50]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[59]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[59]) || (sudoku0[23] !=
                                                                    0 &&
                                                                    sudoku0[23] ==
                                                                    sudoku0[59]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[59]) || (sudoku0[41] !=
                                                                    0 &&
                                                                    sudoku0[41] ==
                                                                    sudoku0[59]) || (sudoku0[50] !=
                                                                    0 &&
                                                                    sudoku0[50] ==
                                                                    sudoku0[59]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[68]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[68]) || (sudoku0[23] !=
                                                                    0 &&
                                                                    sudoku0[23] ==
                                                                    sudoku0[68]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[68]) || (sudoku0[41] !=
                                                                    0 &&
                                                                    sudoku0[41] ==
                                                                    sudoku0[68]) || (sudoku0[50] !=
                                                                    0 &&
                                                                    sudoku0[50] ==
                                                                    sudoku0[68]) || (sudoku0[59] !=
                                                                    0 &&
                                                                    sudoku0[59] ==
                                                                    sudoku0[68]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[77]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[77]) || (sudoku0[23] !=
                                                                    0 &&
                                                                    sudoku0[23] ==
                                                                    sudoku0[77]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[77]) || (sudoku0[41] !=
                                                                    0 &&
                                                                    sudoku0[41] ==
                                                                    sudoku0[77]) || (sudoku0[50] !=
                                                                    0 &&
                                                                    sudoku0[50] ==
                                                                    sudoku0[77]) || (sudoku0[59] !=
                                                                    0 &&
                                                                    sudoku0[59] ==
                                                                    sudoku0[77]) || (sudoku0[68] !=
                                                                    0 &&
                                                                    sudoku0[68] ==
                                                                    sudoku0[77]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[15]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[24]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[24]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[33]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[33]) || (sudoku0[24] !=
                                                                    0 &&
                                                                    sudoku0[24] ==
                                                                    sudoku0[33]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[42]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[42]) || (sudoku0[24] !=
                                                                    0 &&
                                                                    sudoku0[24] ==
                                                                    sudoku0[42]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[42]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[51]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[51]) || (sudoku0[24] !=
                                                                    0 &&
                                                                    sudoku0[24] ==
                                                                    sudoku0[51]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[51]) || (sudoku0[42] !=
                                                                    0 &&
                                                                    sudoku0[42] ==
                                                                    sudoku0[51]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[60]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[60]) || (sudoku0[24] !=
                                                                    0 &&
                                                                    sudoku0[24] ==
                                                                    sudoku0[60]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[60]) || (sudoku0[42] !=
                                                                    0 &&
                                                                    sudoku0[42] ==
                                                                    sudoku0[60]) || (sudoku0[51] !=
                                                                    0 &&
                                                                    sudoku0[51] ==
                                                                    sudoku0[60]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[69]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[69]) || (sudoku0[24] !=
                                                                    0 &&
                                                                    sudoku0[24] ==
                                                                    sudoku0[69]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[69]) || (sudoku0[42] !=
                                                                    0 &&
                                                                    sudoku0[42] ==
                                                                    sudoku0[69]) || (sudoku0[51] !=
                                                                    0 &&
                                                                    sudoku0[51] ==
                                                                    sudoku0[69]) || (sudoku0[60] !=
                                                                    0 &&
                                                                    sudoku0[60] ==
                                                                    sudoku0[69]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[78]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[78]) || (sudoku0[24] !=
                                                                    0 &&
                                                                    sudoku0[24] ==
                                                                    sudoku0[78]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[78]) || (sudoku0[42] !=
                                                                    0 &&
                                                                    sudoku0[42] ==
                                                                    sudoku0[78]) || (sudoku0[51] !=
                                                                    0 &&
                                                                    sudoku0[51] ==
                                                                    sudoku0[78]) || (sudoku0[60] !=
                                                                    0 &&
                                                                    sudoku0[60] ==
                                                                    sudoku0[78]) || (sudoku0[69] !=
                                                                    0 &&
                                                                    sudoku0[69] ==
                                                                    sudoku0[78]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[16]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[25]) || (sudoku0[16] !=
                                                                    0 &&
                                                                    sudoku0[16] ==
                                                                    sudoku0[25]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[34]) || (sudoku0[16] !=
                                                                    0 &&
                                                                    sudoku0[16] ==
                                                                    sudoku0[34]) || (sudoku0[25] !=
                                                                    0 &&
                                                                    sudoku0[25] ==
                                                                    sudoku0[34]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[43]) || (sudoku0[16] !=
                                                                    0 &&
                                                                    sudoku0[16] ==
                                                                    sudoku0[43]) || (sudoku0[25] !=
                                                                    0 &&
                                                                    sudoku0[25] ==
                                                                    sudoku0[43]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[43]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[52]) || (sudoku0[16] !=
                                                                    0 &&
                                                                    sudoku0[16] ==
                                                                    sudoku0[52]) || (sudoku0[25] !=
                                                                    0 &&
                                                                    sudoku0[25] ==
                                                                    sudoku0[52]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[52]) || (sudoku0[43] !=
                                                                    0 &&
                                                                    sudoku0[43] ==
                                                                    sudoku0[52]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[61]) || (sudoku0[16] !=
                                                                    0 &&
                                                                    sudoku0[16] ==
                                                                    sudoku0[61]) || (sudoku0[25] !=
                                                                    0 &&
                                                                    sudoku0[25] ==
                                                                    sudoku0[61]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[61]) || (sudoku0[43] !=
                                                                    0 &&
                                                                    sudoku0[43] ==
                                                                    sudoku0[61]) || (sudoku0[52] !=
                                                                    0 &&
                                                                    sudoku0[52] ==
                                                                    sudoku0[61]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[70]) || (sudoku0[16] !=
                                                                    0 &&
                                                                    sudoku0[16] ==
                                                                    sudoku0[70]) || (sudoku0[25] !=
                                                                    0 &&
                                                                    sudoku0[25] ==
                                                                    sudoku0[70]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[70]) || (sudoku0[43] !=
                                                                    0 &&
                                                                    sudoku0[43] ==
                                                                    sudoku0[70]) || (sudoku0[52] !=
                                                                    0 &&
                                                                    sudoku0[52] ==
                                                                    sudoku0[70]) || (sudoku0[61] !=
                                                                    0 &&
                                                                    sudoku0[61] ==
                                                                    sudoku0[70]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[79]) || (sudoku0[16] !=
                                                                    0 &&
                                                                    sudoku0[16] ==
                                                                    sudoku0[79]) || (sudoku0[25] !=
                                                                    0 &&
                                                                    sudoku0[25] ==
                                                                    sudoku0[79]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[79]) || (sudoku0[43] !=
                                                                    0 &&
                                                                    sudoku0[43] ==
                                                                    sudoku0[79]) || (sudoku0[52] !=
                                                                    0 &&
                                                                    sudoku0[52] ==
                                                                    sudoku0[79]) || (sudoku0[61] !=
                                                                    0 &&
                                                                    sudoku0[61] ==
                                                                    sudoku0[79]) || (sudoku0[70] !=
                                                                    0 &&
                                                                    sudoku0[70] ==
                                                                    sudoku0[79]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[17]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[26]) || (sudoku0[17] !=
                                                                    0 &&
                                                                    sudoku0[17] ==
                                                                    sudoku0[26]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[35]) || (sudoku0[17] !=
                                                                    0 &&
                                                                    sudoku0[17] ==
                                                                    sudoku0[35]) || (sudoku0[26] !=
                                                                    0 &&
                                                                    sudoku0[26] ==
                                                                    sudoku0[35]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[44]) || (sudoku0[17] !=
                                                                    0 &&
                                                                    sudoku0[17] ==
                                                                    sudoku0[44]) || (sudoku0[26] !=
                                                                    0 &&
                                                                    sudoku0[26] ==
                                                                    sudoku0[44]) || (sudoku0[35] !=
                                                                    0 &&
                                                                    sudoku0[35] ==
                                                                    sudoku0[44]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[53]) || (sudoku0[17] !=
                                                                    0 &&
                                                                    sudoku0[17] ==
                                                                    sudoku0[53]) || (sudoku0[26] !=
                                                                    0 &&
                                                                    sudoku0[26] ==
                                                                    sudoku0[53]) || (sudoku0[35] !=
                                                                    0 &&
                                                                    sudoku0[35] ==
                                                                    sudoku0[53]) || (sudoku0[44] !=
                                                                    0 &&
                                                                    sudoku0[44] ==
                                                                    sudoku0[53]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[62]) || (sudoku0[17] !=
                                                                    0 &&
                                                                    sudoku0[17] ==
                                                                    sudoku0[62]) || (sudoku0[26] !=
                                                                    0 &&
                                                                    sudoku0[26] ==
                                                                    sudoku0[62]) || (sudoku0[35] !=
                                                                    0 &&
                                                                    sudoku0[35] ==
                                                                    sudoku0[62]) || (sudoku0[44] !=
                                                                    0 &&
                                                                    sudoku0[44] ==
                                                                    sudoku0[62]) || (sudoku0[53] !=
                                                                    0 &&
                                                                    sudoku0[53] ==
                                                                    sudoku0[62]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[71]) || (sudoku0[17] !=
                                                                    0 &&
                                                                    sudoku0[17] ==
                                                                    sudoku0[71]) || (sudoku0[26] !=
                                                                    0 &&
                                                                    sudoku0[26] ==
                                                                    sudoku0[71]) || (sudoku0[35] !=
                                                                    0 &&
                                                                    sudoku0[35] ==
                                                                    sudoku0[71]) || (sudoku0[44] !=
                                                                    0 &&
                                                                    sudoku0[44] ==
                                                                    sudoku0[71]) || (sudoku0[53] !=
                                                                    0 &&
                                                                    sudoku0[53] ==
                                                                    sudoku0[71]) || (sudoku0[62] !=
                                                                    0 &&
                                                                    sudoku0[62] ==
                                                                    sudoku0[71]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[80]) || (sudoku0[17] !=
                                                                    0 &&
                                                                    sudoku0[17] ==
                                                                    sudoku0[80]) || (sudoku0[26] !=
                                                                    0 &&
                                                                    sudoku0[26] ==
                                                                    sudoku0[80]) || (sudoku0[35] !=
                                                                    0 &&
                                                                    sudoku0[35] ==
                                                                    sudoku0[80]) || (sudoku0[44] !=
                                                                    0 &&
                                                                    sudoku0[44] ==
                                                                    sudoku0[80]) || (sudoku0[53] !=
                                                                    0 &&
                                                                    sudoku0[53] ==
                                                                    sudoku0[80]) || (sudoku0[62] !=
                                                                    0 &&
                                                                    sudoku0[62] ==
                                                                    sudoku0[80]) || (sudoku0[71] !=
                                                                    0 &&
                                                                    sudoku0[71] ==
                                                                    sudoku0[80]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[1]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[2]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[2]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[3]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[3]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[3]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[4]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[4]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[4]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[4]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[5]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[5]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[5]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[5]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[5]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[6]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[6]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[6]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[6]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[6]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[6]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[7]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[7]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[7]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[7]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[7]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[7]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[7]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[8]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[8]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[8]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[8]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[8]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[8]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[8]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[8]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[10]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[11]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[11]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[12]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[12]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[12]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[13]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[13]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[13]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[13]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[14]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[14]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[14]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[14]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[14]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[15]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[15]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[15]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[15]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[15]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[15]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[16]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[16]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[16]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[16]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[16]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[16]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[16]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[17]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[17]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[17]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[17]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[17]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[17]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[17]) || (sudoku0[16] !=
                                                                    0 &&
                                                                    sudoku0[16] ==
                                                                    sudoku0[17]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[19]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[20]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[20]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[21]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[21]) || (sudoku0[20] !=
                                                                    0 &&
                                                                    sudoku0[20] ==
                                                                    sudoku0[21]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[22]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[22]) || (sudoku0[20] !=
                                                                    0 &&
                                                                    sudoku0[20] ==
                                                                    sudoku0[22]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[22]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[23]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[23]) || (sudoku0[20] !=
                                                                    0 &&
                                                                    sudoku0[20] ==
                                                                    sudoku0[23]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[23]) || (sudoku0[22] !=
                                                                    0 &&
                                                                    sudoku0[22] ==
                                                                    sudoku0[23]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[24]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[24]) || (sudoku0[20] !=
                                                                    0 &&
                                                                    sudoku0[20] ==
                                                                    sudoku0[24]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[24]) || (sudoku0[22] !=
                                                                    0 &&
                                                                    sudoku0[22] ==
                                                                    sudoku0[24]) || (sudoku0[23] !=
                                                                    0 &&
                                                                    sudoku0[23] ==
                                                                    sudoku0[24]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[25]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[25]) || (sudoku0[20] !=
                                                                    0 &&
                                                                    sudoku0[20] ==
                                                                    sudoku0[25]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[25]) || (sudoku0[22] !=
                                                                    0 &&
                                                                    sudoku0[22] ==
                                                                    sudoku0[25]) || (sudoku0[23] !=
                                                                    0 &&
                                                                    sudoku0[23] ==
                                                                    sudoku0[25]) || (sudoku0[24] !=
                                                                    0 &&
                                                                    sudoku0[24] ==
                                                                    sudoku0[25]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[26]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[26]) || (sudoku0[20] !=
                                                                    0 &&
                                                                    sudoku0[20] ==
                                                                    sudoku0[26]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[26]) || (sudoku0[22] !=
                                                                    0 &&
                                                                    sudoku0[22] ==
                                                                    sudoku0[26]) || (sudoku0[23] !=
                                                                    0 &&
                                                                    sudoku0[23] ==
                                                                    sudoku0[26]) || (sudoku0[24] !=
                                                                    0 &&
                                                                    sudoku0[24] ==
                                                                    sudoku0[26]) || (sudoku0[25] !=
                                                                    0 &&
                                                                    sudoku0[25] ==
                                                                    sudoku0[26]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[28]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[29]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[29]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[30]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[30]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[30]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[31]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[31]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[31]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[31]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[32]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[32]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[32]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[32]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[32]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[33]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[33]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[33]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[33]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[33]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[33]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[34]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[34]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[34]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[34]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[34]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[34]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[34]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[35]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[35]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[35]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[35]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[35]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[35]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[35]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[35]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[37]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[38]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[38]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[39]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[39]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[39]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[40]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[40]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[40]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[40]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[41]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[41]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[41]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[41]) || (sudoku0[40] !=
                                                                    0 &&
                                                                    sudoku0[40] ==
                                                                    sudoku0[41]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[42]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[42]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[42]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[42]) || (sudoku0[40] !=
                                                                    0 &&
                                                                    sudoku0[40] ==
                                                                    sudoku0[42]) || (sudoku0[41] !=
                                                                    0 &&
                                                                    sudoku0[41] ==
                                                                    sudoku0[42]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[43]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[43]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[43]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[43]) || (sudoku0[40] !=
                                                                    0 &&
                                                                    sudoku0[40] ==
                                                                    sudoku0[43]) || (sudoku0[41] !=
                                                                    0 &&
                                                                    sudoku0[41] ==
                                                                    sudoku0[43]) || (sudoku0[42] !=
                                                                    0 &&
                                                                    sudoku0[42] ==
                                                                    sudoku0[43]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[44]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[44]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[44]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[44]) || (sudoku0[40] !=
                                                                    0 &&
                                                                    sudoku0[40] ==
                                                                    sudoku0[44]) || (sudoku0[41] !=
                                                                    0 &&
                                                                    sudoku0[41] ==
                                                                    sudoku0[44]) || (sudoku0[42] !=
                                                                    0 &&
                                                                    sudoku0[42] ==
                                                                    sudoku0[44]) || (sudoku0[43] !=
                                                                    0 &&
                                                                    sudoku0[43] ==
                                                                    sudoku0[44]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[46]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[47]) || (sudoku0[46] !=
                                                                    0 &&
                                                                    sudoku0[46] ==
                                                                    sudoku0[47]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[48]) || (sudoku0[46] !=
                                                                    0 &&
                                                                    sudoku0[46] ==
                                                                    sudoku0[48]) || (sudoku0[47] !=
                                                                    0 &&
                                                                    sudoku0[47] ==
                                                                    sudoku0[48]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[49]) || (sudoku0[46] !=
                                                                    0 &&
                                                                    sudoku0[46] ==
                                                                    sudoku0[49]) || (sudoku0[47] !=
                                                                    0 &&
                                                                    sudoku0[47] ==
                                                                    sudoku0[49]) || (sudoku0[48] !=
                                                                    0 &&
                                                                    sudoku0[48] ==
                                                                    sudoku0[49]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[50]) || (sudoku0[46] !=
                                                                    0 &&
                                                                    sudoku0[46] ==
                                                                    sudoku0[50]) || (sudoku0[47] !=
                                                                    0 &&
                                                                    sudoku0[47] ==
                                                                    sudoku0[50]) || (sudoku0[48] !=
                                                                    0 &&
                                                                    sudoku0[48] ==
                                                                    sudoku0[50]) || (sudoku0[49] !=
                                                                    0 &&
                                                                    sudoku0[49] ==
                                                                    sudoku0[50]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[51]) || (sudoku0[46] !=
                                                                    0 &&
                                                                    sudoku0[46] ==
                                                                    sudoku0[51]) || (sudoku0[47] !=
                                                                    0 &&
                                                                    sudoku0[47] ==
                                                                    sudoku0[51]) || (sudoku0[48] !=
                                                                    0 &&
                                                                    sudoku0[48] ==
                                                                    sudoku0[51]) || (sudoku0[49] !=
                                                                    0 &&
                                                                    sudoku0[49] ==
                                                                    sudoku0[51]) || (sudoku0[50] !=
                                                                    0 &&
                                                                    sudoku0[50] ==
                                                                    sudoku0[51]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[52]) || (sudoku0[46] !=
                                                                    0 &&
                                                                    sudoku0[46] ==
                                                                    sudoku0[52]) || (sudoku0[47] !=
                                                                    0 &&
                                                                    sudoku0[47] ==
                                                                    sudoku0[52]) || (sudoku0[48] !=
                                                                    0 &&
                                                                    sudoku0[48] ==
                                                                    sudoku0[52]) || (sudoku0[49] !=
                                                                    0 &&
                                                                    sudoku0[49] ==
                                                                    sudoku0[52]) || (sudoku0[50] !=
                                                                    0 &&
                                                                    sudoku0[50] ==
                                                                    sudoku0[52]) || (sudoku0[51] !=
                                                                    0 &&
                                                                    sudoku0[51] ==
                                                                    sudoku0[52]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[53]) || (sudoku0[46] !=
                                                                    0 &&
                                                                    sudoku0[46] ==
                                                                    sudoku0[53]) || (sudoku0[47] !=
                                                                    0 &&
                                                                    sudoku0[47] ==
                                                                    sudoku0[53]) || (sudoku0[48] !=
                                                                    0 &&
                                                                    sudoku0[48] ==
                                                                    sudoku0[53]) || (sudoku0[49] !=
                                                                    0 &&
                                                                    sudoku0[49] ==
                                                                    sudoku0[53]) || (sudoku0[50] !=
                                                                    0 &&
                                                                    sudoku0[50] ==
                                                                    sudoku0[53]) || (sudoku0[51] !=
                                                                    0 &&
                                                                    sudoku0[51] ==
                                                                    sudoku0[53]) || (sudoku0[52] !=
                                                                    0 &&
                                                                    sudoku0[52] ==
                                                                    sudoku0[53]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[55]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[56]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[56]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[57]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[57]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[57]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[58]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[58]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[58]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[58]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[59]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[59]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[59]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[59]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[59]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[60]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[60]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[60]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[60]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[60]) || (sudoku0[59] !=
                                                                    0 &&
                                                                    sudoku0[59] ==
                                                                    sudoku0[60]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[61]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[61]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[61]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[61]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[61]) || (sudoku0[59] !=
                                                                    0 &&
                                                                    sudoku0[59] ==
                                                                    sudoku0[61]) || (sudoku0[60] !=
                                                                    0 &&
                                                                    sudoku0[60] ==
                                                                    sudoku0[61]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[62]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[62]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[62]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[62]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[62]) || (sudoku0[59] !=
                                                                    0 &&
                                                                    sudoku0[59] ==
                                                                    sudoku0[62]) || (sudoku0[60] !=
                                                                    0 &&
                                                                    sudoku0[60] ==
                                                                    sudoku0[62]) || (sudoku0[61] !=
                                                                    0 &&
                                                                    sudoku0[61] ==
                                                                    sudoku0[62]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[64]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[65]) || (sudoku0[64] !=
                                                                    0 &&
                                                                    sudoku0[64] ==
                                                                    sudoku0[65]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[66]) || (sudoku0[64] !=
                                                                    0 &&
                                                                    sudoku0[64] ==
                                                                    sudoku0[66]) || (sudoku0[65] !=
                                                                    0 &&
                                                                    sudoku0[65] ==
                                                                    sudoku0[66]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[67]) || (sudoku0[64] !=
                                                                    0 &&
                                                                    sudoku0[64] ==
                                                                    sudoku0[67]) || (sudoku0[65] !=
                                                                    0 &&
                                                                    sudoku0[65] ==
                                                                    sudoku0[67]) || (sudoku0[66] !=
                                                                    0 &&
                                                                    sudoku0[66] ==
                                                                    sudoku0[67]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[68]) || (sudoku0[64] !=
                                                                    0 &&
                                                                    sudoku0[64] ==
                                                                    sudoku0[68]) || (sudoku0[65] !=
                                                                    0 &&
                                                                    sudoku0[65] ==
                                                                    sudoku0[68]) || (sudoku0[66] !=
                                                                    0 &&
                                                                    sudoku0[66] ==
                                                                    sudoku0[68]) || (sudoku0[67] !=
                                                                    0 &&
                                                                    sudoku0[67] ==
                                                                    sudoku0[68]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[69]) || (sudoku0[64] !=
                                                                    0 &&
                                                                    sudoku0[64] ==
                                                                    sudoku0[69]) || (sudoku0[65] !=
                                                                    0 &&
                                                                    sudoku0[65] ==
                                                                    sudoku0[69]) || (sudoku0[66] !=
                                                                    0 &&
                                                                    sudoku0[66] ==
                                                                    sudoku0[69]) || (sudoku0[67] !=
                                                                    0 &&
                                                                    sudoku0[67] ==
                                                                    sudoku0[69]) || (sudoku0[68] !=
                                                                    0 &&
                                                                    sudoku0[68] ==
                                                                    sudoku0[69]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[70]) || (sudoku0[64] !=
                                                                    0 &&
                                                                    sudoku0[64] ==
                                                                    sudoku0[70]) || (sudoku0[65] !=
                                                                    0 &&
                                                                    sudoku0[65] ==
                                                                    sudoku0[70]) || (sudoku0[66] !=
                                                                    0 &&
                                                                    sudoku0[66] ==
                                                                    sudoku0[70]) || (sudoku0[67] !=
                                                                    0 &&
                                                                    sudoku0[67] ==
                                                                    sudoku0[70]) || (sudoku0[68] !=
                                                                    0 &&
                                                                    sudoku0[68] ==
                                                                    sudoku0[70]) || (sudoku0[69] !=
                                                                    0 &&
                                                                    sudoku0[69] ==
                                                                    sudoku0[70]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[71]) || (sudoku0[64] !=
                                                                    0 &&
                                                                    sudoku0[64] ==
                                                                    sudoku0[71]) || (sudoku0[65] !=
                                                                    0 &&
                                                                    sudoku0[65] ==
                                                                    sudoku0[71]) || (sudoku0[66] !=
                                                                    0 &&
                                                                    sudoku0[66] ==
                                                                    sudoku0[71]) || (sudoku0[67] !=
                                                                    0 &&
                                                                    sudoku0[67] ==
                                                                    sudoku0[71]) || (sudoku0[68] !=
                                                                    0 &&
                                                                    sudoku0[68] ==
                                                                    sudoku0[71]) || (sudoku0[69] !=
                                                                    0 &&
                                                                    sudoku0[69] ==
                                                                    sudoku0[71]) || (sudoku0[70] !=
                                                                    0 &&
                                                                    sudoku0[70] ==
                                                                    sudoku0[71]) || (sudoku0[72] !=
                                                                    0 &&
                                                                    sudoku0[72] ==
                                                                    sudoku0[73]) || (sudoku0[72] !=
                                                                    0 &&
                                                                    sudoku0[72] ==
                                                                    sudoku0[74]) || (sudoku0[73] !=
                                                                    0 &&
                                                                    sudoku0[73] ==
                                                                    sudoku0[74]) || (sudoku0[72] !=
                                                                    0 &&
                                                                    sudoku0[72] ==
                                                                    sudoku0[75]) || (sudoku0[73] !=
                                                                    0 &&
                                                                    sudoku0[73] ==
                                                                    sudoku0[75]) || (sudoku0[74] !=
                                                                    0 &&
                                                                    sudoku0[74] ==
                                                                    sudoku0[75]) || (sudoku0[72] !=
                                                                    0 &&
                                                                    sudoku0[72] ==
                                                                    sudoku0[76]) || (sudoku0[73] !=
                                                                    0 &&
                                                                    sudoku0[73] ==
                                                                    sudoku0[76]) || (sudoku0[74] !=
                                                                    0 &&
                                                                    sudoku0[74] ==
                                                                    sudoku0[76]) || (sudoku0[75] !=
                                                                    0 &&
                                                                    sudoku0[75] ==
                                                                    sudoku0[76]) || (sudoku0[72] !=
                                                                    0 &&
                                                                    sudoku0[72] ==
                                                                    sudoku0[77]) || (sudoku0[73] !=
                                                                    0 &&
                                                                    sudoku0[73] ==
                                                                    sudoku0[77]) || (sudoku0[74] !=
                                                                    0 &&
                                                                    sudoku0[74] ==
                                                                    sudoku0[77]) || (sudoku0[75] !=
                                                                    0 &&
                                                                    sudoku0[75] ==
                                                                    sudoku0[77]) || (sudoku0[76] !=
                                                                    0 &&
                                                                    sudoku0[76] ==
                                                                    sudoku0[77]) || (sudoku0[72] !=
                                                                    0 &&
                                                                    sudoku0[72] ==
                                                                    sudoku0[78]) || (sudoku0[73] !=
                                                                    0 &&
                                                                    sudoku0[73] ==
                                                                    sudoku0[78]) || (sudoku0[74] !=
                                                                    0 &&
                                                                    sudoku0[74] ==
                                                                    sudoku0[78]) || (sudoku0[75] !=
                                                                    0 &&
                                                                    sudoku0[75] ==
                                                                    sudoku0[78]) || (sudoku0[76] !=
                                                                    0 &&
                                                                    sudoku0[76] ==
                                                                    sudoku0[78]) || (sudoku0[77] !=
                                                                    0 &&
                                                                    sudoku0[77] ==
                                                                    sudoku0[78]) || (sudoku0[72] !=
                                                                    0 &&
                                                                    sudoku0[72] ==
                                                                    sudoku0[79]) || (sudoku0[73] !=
                                                                    0 &&
                                                                    sudoku0[73] ==
                                                                    sudoku0[79]) || (sudoku0[74] !=
                                                                    0 &&
                                                                    sudoku0[74] ==
                                                                    sudoku0[79]) || (sudoku0[75] !=
                                                                    0 &&
                                                                    sudoku0[75] ==
                                                                    sudoku0[79]) || (sudoku0[76] !=
                                                                    0 &&
                                                                    sudoku0[76] ==
                                                                    sudoku0[79]) || (sudoku0[77] !=
                                                                    0 &&
                                                                    sudoku0[77] ==
                                                                    sudoku0[79]) || (sudoku0[78] !=
                                                                    0 &&
                                                                    sudoku0[78] ==
                                                                    sudoku0[79]) || (sudoku0[72] !=
                                                                    0 &&
                                                                    sudoku0[72] ==
                                                                    sudoku0[80]) || (sudoku0[73] !=
                                                                    0 &&
                                                                    sudoku0[73] ==
                                                                    sudoku0[80]) || (sudoku0[74] !=
                                                                    0 &&
                                                                    sudoku0[74] ==
                                                                    sudoku0[80]) || (sudoku0[75] !=
                                                                    0 &&
                                                                    sudoku0[75] ==
                                                                    sudoku0[80]) || (sudoku0[76] !=
                                                                    0 &&
                                                                    sudoku0[76] ==
                                                                    sudoku0[80]) || (sudoku0[77] !=
                                                                    0 &&
                                                                    sudoku0[77] ==
                                                                    sudoku0[80]) || (sudoku0[78] !=
                                                                    0 &&
                                                                    sudoku0[78] ==
                                                                    sudoku0[80]) || (sudoku0[79] !=
                                                                    0 &&
                                                                    sudoku0[79] ==
                                                                    sudoku0[80]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[1]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[2]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[2]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[9]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[9]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[9]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[10]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[10]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[10]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[10]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[11]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[11]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[11]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[11]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[11]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[18]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[18]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[18]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[18]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[18]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[18]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[19]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[19]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[19]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[19]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[19]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[19]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[19]) || (sudoku0[0] !=
                                                                    0 &&
                                                                    sudoku0[0] ==
                                                                    sudoku0[20]) || (sudoku0[1] !=
                                                                    0 &&
                                                                    sudoku0[1] ==
                                                                    sudoku0[20]) || (sudoku0[2] !=
                                                                    0 &&
                                                                    sudoku0[2] ==
                                                                    sudoku0[20]) || (sudoku0[9] !=
                                                                    0 &&
                                                                    sudoku0[9] ==
                                                                    sudoku0[20]) || (sudoku0[10] !=
                                                                    0 &&
                                                                    sudoku0[10] ==
                                                                    sudoku0[20]) || (sudoku0[11] !=
                                                                    0 &&
                                                                    sudoku0[11] ==
                                                                    sudoku0[20]) || (sudoku0[18] !=
                                                                    0 &&
                                                                    sudoku0[18] ==
                                                                    sudoku0[20]) || (sudoku0[19] !=
                                                                    0 &&
                                                                    sudoku0[19] ==
                                                                    sudoku0[20]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[28]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[29]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[29]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[36]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[36]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[36]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[37]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[37]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[37]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[37]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[38]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[38]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[38]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[38]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[38]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[45]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[45]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[45]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[45]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[45]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[45]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[46]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[46]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[46]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[46]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[46]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[46]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[46]) || (sudoku0[27] !=
                                                                    0 &&
                                                                    sudoku0[27] ==
                                                                    sudoku0[47]) || (sudoku0[28] !=
                                                                    0 &&
                                                                    sudoku0[28] ==
                                                                    sudoku0[47]) || (sudoku0[29] !=
                                                                    0 &&
                                                                    sudoku0[29] ==
                                                                    sudoku0[47]) || (sudoku0[36] !=
                                                                    0 &&
                                                                    sudoku0[36] ==
                                                                    sudoku0[47]) || (sudoku0[37] !=
                                                                    0 &&
                                                                    sudoku0[37] ==
                                                                    sudoku0[47]) || (sudoku0[38] !=
                                                                    0 &&
                                                                    sudoku0[38] ==
                                                                    sudoku0[47]) || (sudoku0[45] !=
                                                                    0 &&
                                                                    sudoku0[45] ==
                                                                    sudoku0[47]) || (sudoku0[46] !=
                                                                    0 &&
                                                                    sudoku0[46] ==
                                                                    sudoku0[47]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[55]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[56]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[56]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[63]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[63]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[63]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[64]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[64]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[64]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[64]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[65]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[65]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[65]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[65]) || (sudoku0[64] !=
                                                                    0 &&
                                                                    sudoku0[64] ==
                                                                    sudoku0[65]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[72]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[72]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[72]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[72]) || (sudoku0[64] !=
                                                                    0 &&
                                                                    sudoku0[64] ==
                                                                    sudoku0[72]) || (sudoku0[65] !=
                                                                    0 &&
                                                                    sudoku0[65] ==
                                                                    sudoku0[72]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[73]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[73]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[73]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[73]) || (sudoku0[64] !=
                                                                    0 &&
                                                                    sudoku0[64] ==
                                                                    sudoku0[73]) || (sudoku0[65] !=
                                                                    0 &&
                                                                    sudoku0[65] ==
                                                                    sudoku0[73]) || (sudoku0[72] !=
                                                                    0 &&
                                                                    sudoku0[72] ==
                                                                    sudoku0[73]) || (sudoku0[54] !=
                                                                    0 &&
                                                                    sudoku0[54] ==
                                                                    sudoku0[74]) || (sudoku0[55] !=
                                                                    0 &&
                                                                    sudoku0[55] ==
                                                                    sudoku0[74]) || (sudoku0[56] !=
                                                                    0 &&
                                                                    sudoku0[56] ==
                                                                    sudoku0[74]) || (sudoku0[63] !=
                                                                    0 &&
                                                                    sudoku0[63] ==
                                                                    sudoku0[74]) || (sudoku0[64] !=
                                                                    0 &&
                                                                    sudoku0[64] ==
                                                                    sudoku0[74]) || (sudoku0[65] !=
                                                                    0 &&
                                                                    sudoku0[65] ==
                                                                    sudoku0[74]) || (sudoku0[72] !=
                                                                    0 &&
                                                                    sudoku0[72] ==
                                                                    sudoku0[74]) || (sudoku0[73] !=
                                                                    0 &&
                                                                    sudoku0[73] ==
                                                                    sudoku0[74]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[4]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[5]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[5]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[12]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[12]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[12]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[13]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[13]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[13]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[13]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[14]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[14]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[14]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[14]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[14]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[21]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[21]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[21]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[21]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[21]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[21]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[22]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[22]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[22]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[22]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[22]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[22]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[22]) || (sudoku0[3] !=
                                                                    0 &&
                                                                    sudoku0[3] ==
                                                                    sudoku0[23]) || (sudoku0[4] !=
                                                                    0 &&
                                                                    sudoku0[4] ==
                                                                    sudoku0[23]) || (sudoku0[5] !=
                                                                    0 &&
                                                                    sudoku0[5] ==
                                                                    sudoku0[23]) || (sudoku0[12] !=
                                                                    0 &&
                                                                    sudoku0[12] ==
                                                                    sudoku0[23]) || (sudoku0[13] !=
                                                                    0 &&
                                                                    sudoku0[13] ==
                                                                    sudoku0[23]) || (sudoku0[14] !=
                                                                    0 &&
                                                                    sudoku0[14] ==
                                                                    sudoku0[23]) || (sudoku0[21] !=
                                                                    0 &&
                                                                    sudoku0[21] ==
                                                                    sudoku0[23]) || (sudoku0[22] !=
                                                                    0 &&
                                                                    sudoku0[22] ==
                                                                    sudoku0[23]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[31]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[32]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[32]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[39]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[39]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[39]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[40]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[40]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[40]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[40]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[41]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[41]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[41]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[41]) || (sudoku0[40] !=
                                                                    0 &&
                                                                    sudoku0[40] ==
                                                                    sudoku0[41]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[48]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[48]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[48]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[48]) || (sudoku0[40] !=
                                                                    0 &&
                                                                    sudoku0[40] ==
                                                                    sudoku0[48]) || (sudoku0[41] !=
                                                                    0 &&
                                                                    sudoku0[41] ==
                                                                    sudoku0[48]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[49]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[49]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[49]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[49]) || (sudoku0[40] !=
                                                                    0 &&
                                                                    sudoku0[40] ==
                                                                    sudoku0[49]) || (sudoku0[41] !=
                                                                    0 &&
                                                                    sudoku0[41] ==
                                                                    sudoku0[49]) || (sudoku0[48] !=
                                                                    0 &&
                                                                    sudoku0[48] ==
                                                                    sudoku0[49]) || (sudoku0[30] !=
                                                                    0 &&
                                                                    sudoku0[30] ==
                                                                    sudoku0[50]) || (sudoku0[31] !=
                                                                    0 &&
                                                                    sudoku0[31] ==
                                                                    sudoku0[50]) || (sudoku0[32] !=
                                                                    0 &&
                                                                    sudoku0[32] ==
                                                                    sudoku0[50]) || (sudoku0[39] !=
                                                                    0 &&
                                                                    sudoku0[39] ==
                                                                    sudoku0[50]) || (sudoku0[40] !=
                                                                    0 &&
                                                                    sudoku0[40] ==
                                                                    sudoku0[50]) || (sudoku0[41] !=
                                                                    0 &&
                                                                    sudoku0[41] ==
                                                                    sudoku0[50]) || (sudoku0[48] !=
                                                                    0 &&
                                                                    sudoku0[48] ==
                                                                    sudoku0[50]) || (sudoku0[49] !=
                                                                    0 &&
                                                                    sudoku0[49] ==
                                                                    sudoku0[50]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[58]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[59]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[59]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[66]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[66]) || (sudoku0[59] !=
                                                                    0 &&
                                                                    sudoku0[59] ==
                                                                    sudoku0[66]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[67]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[67]) || (sudoku0[59] !=
                                                                    0 &&
                                                                    sudoku0[59] ==
                                                                    sudoku0[67]) || (sudoku0[66] !=
                                                                    0 &&
                                                                    sudoku0[66] ==
                                                                    sudoku0[67]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[68]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[68]) || (sudoku0[59] !=
                                                                    0 &&
                                                                    sudoku0[59] ==
                                                                    sudoku0[68]) || (sudoku0[66] !=
                                                                    0 &&
                                                                    sudoku0[66] ==
                                                                    sudoku0[68]) || (sudoku0[67] !=
                                                                    0 &&
                                                                    sudoku0[67] ==
                                                                    sudoku0[68]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[75]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[75]) || (sudoku0[59] !=
                                                                    0 &&
                                                                    sudoku0[59] ==
                                                                    sudoku0[75]) || (sudoku0[66] !=
                                                                    0 &&
                                                                    sudoku0[66] ==
                                                                    sudoku0[75]) || (sudoku0[67] !=
                                                                    0 &&
                                                                    sudoku0[67] ==
                                                                    sudoku0[75]) || (sudoku0[68] !=
                                                                    0 &&
                                                                    sudoku0[68] ==
                                                                    sudoku0[75]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[76]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[76]) || (sudoku0[59] !=
                                                                    0 &&
                                                                    sudoku0[59] ==
                                                                    sudoku0[76]) || (sudoku0[66] !=
                                                                    0 &&
                                                                    sudoku0[66] ==
                                                                    sudoku0[76]) || (sudoku0[67] !=
                                                                    0 &&
                                                                    sudoku0[67] ==
                                                                    sudoku0[76]) || (sudoku0[68] !=
                                                                    0 &&
                                                                    sudoku0[68] ==
                                                                    sudoku0[76]) || (sudoku0[75] !=
                                                                    0 &&
                                                                    sudoku0[75] ==
                                                                    sudoku0[76]) || (sudoku0[57] !=
                                                                    0 &&
                                                                    sudoku0[57] ==
                                                                    sudoku0[77]) || (sudoku0[58] !=
                                                                    0 &&
                                                                    sudoku0[58] ==
                                                                    sudoku0[77]) || (sudoku0[59] !=
                                                                    0 &&
                                                                    sudoku0[59] ==
                                                                    sudoku0[77]) || (sudoku0[66] !=
                                                                    0 &&
                                                                    sudoku0[66] ==
                                                                    sudoku0[77]) || (sudoku0[67] !=
                                                                    0 &&
                                                                    sudoku0[67] ==
                                                                    sudoku0[77]) || (sudoku0[68] !=
                                                                    0 &&
                                                                    sudoku0[68] ==
                                                                    sudoku0[77]) || (sudoku0[75] !=
                                                                    0 &&
                                                                    sudoku0[75] ==
                                                                    sudoku0[77]) || (sudoku0[76] !=
                                                                    0 &&
                                                                    sudoku0[76] ==
                                                                    sudoku0[77]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[7]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[8]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[8]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[15]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[15]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[15]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[16]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[16]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[16]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[16]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[17]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[17]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[17]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[17]) || (sudoku0[16] !=
                                                                    0 &&
                                                                    sudoku0[16] ==
                                                                    sudoku0[17]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[24]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[24]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[24]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[24]) || (sudoku0[16] !=
                                                                    0 &&
                                                                    sudoku0[16] ==
                                                                    sudoku0[24]) || (sudoku0[17] !=
                                                                    0 &&
                                                                    sudoku0[17] ==
                                                                    sudoku0[24]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[25]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[25]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[25]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[25]) || (sudoku0[16] !=
                                                                    0 &&
                                                                    sudoku0[16] ==
                                                                    sudoku0[25]) || (sudoku0[17] !=
                                                                    0 &&
                                                                    sudoku0[17] ==
                                                                    sudoku0[25]) || (sudoku0[24] !=
                                                                    0 &&
                                                                    sudoku0[24] ==
                                                                    sudoku0[25]) || (sudoku0[6] !=
                                                                    0 &&
                                                                    sudoku0[6] ==
                                                                    sudoku0[26]) || (sudoku0[7] !=
                                                                    0 &&
                                                                    sudoku0[7] ==
                                                                    sudoku0[26]) || (sudoku0[8] !=
                                                                    0 &&
                                                                    sudoku0[8] ==
                                                                    sudoku0[26]) || (sudoku0[15] !=
                                                                    0 &&
                                                                    sudoku0[15] ==
                                                                    sudoku0[26]) || (sudoku0[16] !=
                                                                    0 &&
                                                                    sudoku0[16] ==
                                                                    sudoku0[26]) || (sudoku0[17] !=
                                                                    0 &&
                                                                    sudoku0[17] ==
                                                                    sudoku0[26]) || (sudoku0[24] !=
                                                                    0 &&
                                                                    sudoku0[24] ==
                                                                    sudoku0[26]) || (sudoku0[25] !=
                                                                    0 &&
                                                                    sudoku0[25] ==
                                                                    sudoku0[26]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[34]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[35]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[35]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[42]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[42]) || (sudoku0[35] !=
                                                                    0 &&
                                                                    sudoku0[35] ==
                                                                    sudoku0[42]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[43]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[43]) || (sudoku0[35] !=
                                                                    0 &&
                                                                    sudoku0[35] ==
                                                                    sudoku0[43]) || (sudoku0[42] !=
                                                                    0 &&
                                                                    sudoku0[42] ==
                                                                    sudoku0[43]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[44]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[44]) || (sudoku0[35] !=
                                                                    0 &&
                                                                    sudoku0[35] ==
                                                                    sudoku0[44]) || (sudoku0[42] !=
                                                                    0 &&
                                                                    sudoku0[42] ==
                                                                    sudoku0[44]) || (sudoku0[43] !=
                                                                    0 &&
                                                                    sudoku0[43] ==
                                                                    sudoku0[44]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[51]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[51]) || (sudoku0[35] !=
                                                                    0 &&
                                                                    sudoku0[35] ==
                                                                    sudoku0[51]) || (sudoku0[42] !=
                                                                    0 &&
                                                                    sudoku0[42] ==
                                                                    sudoku0[51]) || (sudoku0[43] !=
                                                                    0 &&
                                                                    sudoku0[43] ==
                                                                    sudoku0[51]) || (sudoku0[44] !=
                                                                    0 &&
                                                                    sudoku0[44] ==
                                                                    sudoku0[51]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[52]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[52]) || (sudoku0[35] !=
                                                                    0 &&
                                                                    sudoku0[35] ==
                                                                    sudoku0[52]) || (sudoku0[42] !=
                                                                    0 &&
                                                                    sudoku0[42] ==
                                                                    sudoku0[52]) || (sudoku0[43] !=
                                                                    0 &&
                                                                    sudoku0[43] ==
                                                                    sudoku0[52]) || (sudoku0[44] !=
                                                                    0 &&
                                                                    sudoku0[44] ==
                                                                    sudoku0[52]) || (sudoku0[51] !=
                                                                    0 &&
                                                                    sudoku0[51] ==
                                                                    sudoku0[52]) || (sudoku0[33] !=
                                                                    0 &&
                                                                    sudoku0[33] ==
                                                                    sudoku0[53]) || (sudoku0[34] !=
                                                                    0 &&
                                                                    sudoku0[34] ==
                                                                    sudoku0[53]) || (sudoku0[35] !=
                                                                    0 &&
                                                                    sudoku0[35] ==
                                                                    sudoku0[53]) || (sudoku0[42] !=
                                                                    0 &&
                                                                    sudoku0[42] ==
                                                                    sudoku0[53]) || (sudoku0[43] !=
                                                                    0 &&
                                                                    sudoku0[43] ==
                                                                    sudoku0[53]) || (sudoku0[44] !=
                                                                    0 &&
                                                                    sudoku0[44] ==
                                                                    sudoku0[53]) || (sudoku0[51] !=
                                                                    0 &&
                                                                    sudoku0[51] ==
                                                                    sudoku0[53]) || (sudoku0[52] !=
                                                                    0 &&
                                                                    sudoku0[52] ==
                                                                    sudoku0[53]) || (sudoku0[60] !=
                                                                    0 &&
                                                                    sudoku0[60] ==
                                                                    sudoku0[61]) || (sudoku0[60] !=
                                                                    0 &&
                                                                    sudoku0[60] ==
                                                                    sudoku0[62]) || (sudoku0[61] !=
                                                                    0 &&
                                                                    sudoku0[61] ==
                                                                    sudoku0[62]) || (sudoku0[60] !=
                                                                    0 &&
                                                                    sudoku0[60] ==
                                                                    sudoku0[69]) || (sudoku0[61] !=
                                                                    0 &&
                                                                    sudoku0[61] ==
                                                                    sudoku0[69]) || (sudoku0[62] !=
                                                                    0 &&
                                                                    sudoku0[62] ==
                                                                    sudoku0[69]) || (sudoku0[60] !=
                                                                    0 &&
                                                                    sudoku0[60] ==
                                                                    sudoku0[70]) || (sudoku0[61] !=
                                                                    0 &&
                                                                    sudoku0[61] ==
                                                                    sudoku0[70]) || (sudoku0[62] !=
                                                                    0 &&
                                                                    sudoku0[62] ==
                                                                    sudoku0[70]) || (sudoku0[69] !=
                                                                    0 &&
                                                                    sudoku0[69] ==
                                                                    sudoku0[70]) || (sudoku0[60] !=
                                                                    0 &&
                                                                    sudoku0[60] ==
                                                                    sudoku0[71]) || (sudoku0[61] !=
                                                                    0 &&
                                                                    sudoku0[61] ==
                                                                    sudoku0[71]) || (sudoku0[62] !=
                                                                    0 &&
                                                                    sudoku0[62] ==
                                                                    sudoku0[71]) || (sudoku0[69] !=
                                                                    0 &&
                                                                    sudoku0[69] ==
                                                                    sudoku0[71]) || (sudoku0[70] !=
                                                                    0 &&
                                                                    sudoku0[70] ==
                                                                    sudoku0[71]) || (sudoku0[60] !=
                                                                    0 &&
                                                                    sudoku0[60] ==
                                                                    sudoku0[78]) || (sudoku0[61] !=
                                                                    0 &&
                                                                    sudoku0[61] ==
                                                                    sudoku0[78]) || (sudoku0[62] !=
                                                                    0 &&
                                                                    sudoku0[62] ==
                                                                    sudoku0[78]) || (sudoku0[69] !=
                                                                    0 &&
                                                                    sudoku0[69] ==
                                                                    sudoku0[78]) || (sudoku0[70] !=
                                                                    0 &&
                                                                    sudoku0[70] ==
                                                                    sudoku0[78]) || (sudoku0[71] !=
                                                                    0 &&
                                                                    sudoku0[71] ==
                                                                    sudoku0[78]) || (sudoku0[60] !=
                                                                    0 &&
                                                                    sudoku0[60] ==
                                                                    sudoku0[79]) || (sudoku0[61] !=
                                                                    0 &&
                                                                    sudoku0[61] ==
                                                                    sudoku0[79]) || (sudoku0[62] !=
                                                                    0 &&
                                                                    sudoku0[62] ==
                                                                    sudoku0[79]) || (sudoku0[69] !=
                                                                    0 &&
                                                                    sudoku0[69] ==
                                                                    sudoku0[79]) || (sudoku0[70] !=
                                                                    0 &&
                                                                    sudoku0[70] ==
                                                                    sudoku0[79]) || (sudoku0[71] !=
                                                                    0 &&
                                                                    sudoku0[71] ==
                                                                    sudoku0[79]) || (sudoku0[78] !=
                                                                    0 &&
                                                                    sudoku0[78] ==
                                                                    sudoku0[79]) || (sudoku0[60] !=
                                                                    0 &&
                                                                    sudoku0[60] ==
                                                                    sudoku0[80]) || (sudoku0[61] !=
                                                                    0 &&
                                                                    sudoku0[61] ==
                                                                    sudoku0[80]) || (sudoku0[62] !=
                                                                    0 &&
                                                                    sudoku0[62] ==
                                                                    sudoku0[80]) || (sudoku0[69] !=
                                                                    0 &&
                                                                    sudoku0[69] ==
                                                                    sudoku0[80]) || (sudoku0[70] !=
                                                                    0 &&
                                                                    sudoku0[70] ==
                                                                    sudoku0[80]) || (sudoku0[71] !=
                                                                    0 &&
                                                                    sudoku0[71] ==
                                                                    sudoku0[80]) || (sudoku0[78] !=
                                                                    0 &&
                                                                    sudoku0[78] ==
                                                                    sudoku0[80]) || (sudoku0[79] !=
                                                                    0 &&
                                                                    sudoku0[79] ==
                                                                    sudoku0[80]))
      return false;
    if (sudoku_done(sudoku0))
      return true;
    for (int i = 0 ; i <= 80; i ++)
      if (sudoku0[i] == 0)
    {
      for (int p = 1 ; p <= 9; p ++)
      {
        sudoku0[i] = p;
        if (solve(sudoku0))
          return true;
      }
      sudoku0[i] = 0;
      return false;
    }
    return false;
  }
  
  
  public static void Main(String[] args)
  {
    int[] sudoku0 = read_sudoku();
    print_sudoku(sudoku0);
    if (solve(sudoku0))
      print_sudoku(sudoku0);
    else
      Console.Write("no solution\n");
  }
  
}

