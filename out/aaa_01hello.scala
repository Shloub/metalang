object aaa_01hello
{
  
  
  def main(args : Array[String])
  {
    printf("Hello World");
    var a: Int = 5;
    printf("%d \n%dfoo", (4 + 6) * 2, a);
    var b: Boolean = 1 + (1 + 1) * 2 * (3 + 8) / 4 - (1 - 2) - 3 == 12 && true;
    if (b)
      printf("True");
    else
      printf("False");
    printf("\n");
    var c: Boolean = (3 * (4 + 5 + 6) * 2 == 45) == false;
    if (c)
      printf("True");
    else
      printf("False");
    printf(" ");
    var d: Boolean = (2 == 1) == false;
    if (d)
      printf("True");
    else
      printf("False");
    printf(" %d%d", (4 + 1) / 3 / (2 + 1), 4 * 1 / 3 / 2 * 1);
    var e: Boolean = !(!(a == 0) && !(a == 4));
    if (e)
      printf("True");
    else
      printf("False");
    var f: Boolean = true && !false && !(true && false);
    if (f)
      printf("True");
    else
      printf("False");
    printf("\n");
  }
  
}

