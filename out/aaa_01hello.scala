object aaa_01hello
{
  
  
  def main(args : Array[String])
  {
    printf("Hello World");
    var a: Int = 5;
    printf("%d \n%dfoo", (4 + 6) * 2, a);
    if (1 + (1 + 1) * 2 * (3 + 8) / 4 - (1 - 2) - 3 == 12 && true)
      printf("True");
    else
      printf("False");
    printf("\n");
    if ((3 * (4 + 5 + 6) * 2 == 45) == false)
      printf("True");
    else
      printf("False");
    printf(" ");
    if ((2 == 1) == false)
      printf("True");
    else
      printf("False");
    printf(" %d%d", (4 + 1) / 3 / (2 + 1), 4 * 1 / 3 / 2 * 1);
    if (!(!(a == 0) && !(a == 4)))
      printf("True");
    else
      printf("False");
    if (true && !false && !(true && false))
      printf("True");
    else
      printf("False");
    printf("\n");
  }
  
}

