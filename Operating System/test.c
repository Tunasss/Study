/*

2) Write a C program that read a book's information (title, author, subject and book ID) and then print again.
3) Write a C program that read a person's information (last name, first name, age, nationality, height, weight, job title) and then print again.
4) Write a C program that add two distances (feet, inch) using structure.
5) Write a C program that ask user to choose 3 options, in which:

Option 1: convert a hour format from hh.mm.ss to seconds

Option 2: convert seconds to a hour format hh:mm:ss

Option 3: add two times (hh:mm:ss)

6) Create a structure Student with fields: name, roll_number, marks.

Write a program that allows the user to input the data for 10 students, and create functions to:

Print all students who scored more than a specified grade.

Find the student with the highest marks.
*/

// 1) Write a C program that add two or more complex numbers using structure.
#include <stdio.h>

struct Complex {
    float real;
    float imag;
};

int main() {
    int n, i;
    struct Complex num, sum = {0, 0};

    printf("Enter number of complex numbers: ");
    scanf("%d", &n);

    for (i = 0; i < n; i++) {
        printf("Enter complex number %d (real imaginary): ", i + 1);
        scanf("%f %f", &num.real, &num.imag);

        sum.real += num.real;
        sum.imag += num.imag;
    }

    printf("\nSum = %.2f + %.2fi\n", sum.real, sum.imag);

    return 0;
}
/* Example

Enter number of complex numbers: 3  
Enter complex number 1 (real imaginary): 2 3
Enter complex number 2 (real imaginary): -1 4
Enter complex number 3 (real imaginary): 5 -2

Sum = 6.00 + 5.00i
*/
