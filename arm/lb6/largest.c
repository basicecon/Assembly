// read from stdin two numbers
// print the larger one
#include <stdio.h>
//#define MAX(x, y) (((x) > (y)) ? (x) : (y))

main()
{
	int x;
	int y;
	scanf("%d", &x);
	scanf("%d", &y);
	if (x > y) {
		printf("MAX=%d\n", x);
	}
	if (y > x) {
		printf("MAX=%d\n", y);
	}
}
