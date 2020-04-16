#include <stdio.h>



int main(void)
{
	int x;
	char s[12];
	printf("enter your name\n");
	scanf("%s",s);
	printf("enter your age\n");
	scanf("%i", &x);
	printf("%s %i  \n",s, x);
	return 0;
}