import groovy.transform.Field
import java.util.*


@Field Scanner scanner = new Scanner(System.in)
int[] t = new int[2]
for (int d = 0 ; d < 2; d++)
{
  if (scanner.hasNext("^-")){
    scanner.next("^-");
    t[d] = -scanner.nextInt();
  }else{
    t[d] = scanner.nextInt();
  }
  scanner.findWithinHorizon("[\n\r ]*", 1)
}
System.out.printf("%s - %s\n", t[0], t[1]);

