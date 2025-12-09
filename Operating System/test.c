#include <stdio.h>
#include <math.h>
#include <conio.h>

void nhapMang(double a[], int *n) {
    do {
        scanf("%d", n);
        if (*n <= 5 || *n >= 500) {
            printf("Gia tri n khong hop le. Vui long nhap lai!\n");
        }
    } 
    while (*n <= 5 || *n >= 500);

    for (int i = 0; i < *n; i++) {
        printf("a[%d] = ", i);
        scanf("%lf", &a[i]);
    }
}

void xuatMang(double a[], int n) {
    for (int i = 0; i < n; i++) {
        printf("%.2lf  ", a[i]);
    }
    printf("\n");
}

double tinhS(double a[], int n) {
    double S = 0;
    double tu_so_sum = 0; 
    
    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            tu_so_sum += a[i];
        } else {
            tu_so_sum -= a[i];
        }

        int k = i + 1;
        double mau_so = (double)k * (k + 1) / 2.0;
        double term = pow(tu_so_sum, k) / mau_so;
        
        S += term;
    }
    return S;
}

void cauD(double a[], int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = i + 1; j < n; j++) {
            if (a[i] < a[j]) { 
                double temp = a[i];
                a[i] = a[j];
                a[j] = temp;
            }
        }
    }
    
    printf("\nMang sau khi sap xep giam dan:\n");
    xuatMang(a, n);

    double tu_so = a[0] + a[n-2];
    
    double mau_so = 0;
    for (int k = 1; k <= n; k++) {
        if (k % 2 != 0) {
            mau_so += k; 
        } else {
            mau_so -= k; 
        }
    }

    if (mau_so == 0) {
        printf("Khong the tinh S2 vi mau so bang 0.\n");
    } else {
        double S2 = tu_so / mau_so;
        printf("Gia tri S2 = %.4lf\n", S2);
    }
}

int main() {
    int n;
    double a[505];

    printf("\nCau a: Nhap mang \n");
    nhapMang(a, &n);

    printf("\nCau b: Xuat mang \n");
    printf("\nMang hien tai: \n");
    xuatMang(a, n);

    printf("\nCau c: Tinh S \n");
    double S = tinhS(a, n);
    printf("Tong S = %.4lf\n", S);

    printf("\nCau d: Sap xep va tinh S2 \n");
    cauD(a, n);

    getch();
    return 0;
}