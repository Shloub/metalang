import java.util.*;

public class aaa_021if
{
  
  static void testA(boolean a, boolean b)
  {
    if (a)
        if (b)
            System.out.print("A");
        else
            System.out.print("B");
    else if (b)
        System.out.print("C");
    else
        System.out.print("D");
  }
  
  static void testB(boolean a, boolean b)
  {
    if (a)
        System.out.print("A");
    else if (b)
        System.out.print("B");
    else
        System.out.print("C");
  }
  
  static void testC(boolean a, boolean b)
  {
    if (a)
        if (b)
            System.out.print("A");
        else
            System.out.print("B");
    else
        System.out.print("C");
  }
  
  static void testD(boolean a, boolean b)
  {
    if (a)
    {
        if (b)
            System.out.print("A");
        else
            System.out.print("B");
        System.out.print("C");
    }
    else
        System.out.print("D");
  }
  
  static void testE(boolean a, boolean b)
  {
    if (a)
    {
        if (b)
            System.out.print("A");
    }
    else
    {
        if (b)
            System.out.print("C");
        else
            System.out.print("D");
        System.out.print("E");
    }
  }
  
  static void test(boolean a, boolean b)
  {
    testD(a, b);
    testE(a, b);
    System.out.print("\n");
  }
  
  
  public static void main(String args[])
  {
    test(true, true);
    test(true, false);
    test(false, true);
    test(false, false);
  }
  
}

