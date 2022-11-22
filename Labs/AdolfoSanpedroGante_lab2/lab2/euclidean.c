#include <stdio.h>

int main(void) {
	//init variables
	int num1;
	int num2;
	int remainder;

	//Get two positive integers
	printf("Enter the first positive integer: ");
	scanf("%d", &num1);
	printf("Enter the second positive integer: ");
	scanf("%d", &num2);

	//exchanges num1 and num2 if num1 < num2
	if (num1 < num2) {
		int temp = num1;
		num1 = num2;
		num2 = temp;
	}

	//Calcs GCD
	remainder = num1 % num2;
	while(remainder > 0) {
		num1 = num2;
		num2 = remainder;
		remainder = num1 % num2;
	}
	printf("The GCD is %d\n", num2);

	return 0;
}
