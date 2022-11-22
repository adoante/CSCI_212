#include <stdio.h>

int main(void) {
	
	int terms;
	int firstTerm = 1;
	int secondTerm = 1;
	int nthTerm = firstTerm + secondTerm;

	printf("Enter Fibonacci term: ");
	scanf("%d", &terms);

	if (terms <= 0) {
		printf("Not part of our Fibonacci squence!\n");
		return 0;
	}
	if (terms == 1) {
		printf("The %dst Fibonacci number is 1.\n", terms);
		return 0;
	}
	if (terms == 2) {
		printf("The %dnd Fibonacci number is 1.\n", terms);
		return 0;
	}

	for (int i = 3; i < terms; ++i) {
		firstTerm = secondTerm;
		secondTerm = nthTerm;
		nthTerm = secondTerm + firstTerm;
	}

	printf("The %dth Fibonacci number is %d\n.", terms, nthTerm);
	return 0;
}
