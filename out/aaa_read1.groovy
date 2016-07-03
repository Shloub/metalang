import groovy.transform.Field
import java.util.*


@Field Scanner scanner = new Scanner(System.in)
char[] str = scanner.nextLine().toCharArray()
for (int i = 0; i < 12; i++)
    print(str[i])

