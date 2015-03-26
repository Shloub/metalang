import java.util.*

boolean palindrome2(int[] pow2, int n)
{
  boolean[] t = new boolean[20]
  for (int i = 0 ; i < 20; i++)
    t[i] = (((int)(n / pow2[i])) % 2) == 1
  int nnum = 0
  for (int j = 1 ; j <= 19; j ++)
    if (t[j])
    nnum = j
  for (int k = 0 ; k <= (int)(nnum / 2); k ++)
    if (t[k] != t[nnum - k])
    return false
  return true
}



int p = 1
int[] pow2 = new int[20]
for (int i = 0 ; i < 20; i++)
{
  p *= 2;
  pow2[i] = (int)(p / 2)
}
int sum = 0
for (int d = 1 ; d <= 9; d ++)
{
  if (palindrome2(pow2, d))
  {
    System.out.printf("%s\n", d);
    sum += d;
  }
  if (palindrome2(pow2, d * 10 + d))
  {
    System.out.printf("%s\n", d * 10 + d);
    sum += d * 10 + d;
  }
}
for (int a0 = 0 ; a0 <= 4; a0 ++)
{
  int a = a0 * 2 + 1
  for (int b = 0 ; b <= 9; b ++)
  {
    for (int c = 0 ; c <= 9; c ++)
    {
      int num0 = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a
      if (palindrome2(pow2, num0))
      {
        System.out.printf("%s\n", num0);
        sum += num0;
      }
      int num1 = a * 10000 + b * 1000 + c * 100 + b * 10 + a
      if (palindrome2(pow2, num1))
      {
        System.out.printf("%s\n", num1);
        sum += num1;
      }
    }
    int num2 = a * 100 + b * 10 + a
    if (palindrome2(pow2, num2))
    {
      System.out.printf("%s\n", num2);
      sum += num2;
    }
    int num3 = a * 1000 + b * 100 + b * 10 + a
    if (palindrome2(pow2, num3))
    {
      System.out.printf("%s\n", num3);
      sum += num3;
    }
  }
}
System.out.printf("sum=%s\n", sum);
