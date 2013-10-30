
#include <stdio.h>
#include <assert.h>

int a[] = { 5, 4, 6, 7};

main()
{
	int sum = addarray(sizeof(a)/sizeof(int), a);
	//printf("sum = %d\n", sum);
	assert(sum==22);
	printf("addarray test passed.\n");
	return 0;
}
