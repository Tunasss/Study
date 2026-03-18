#include <bits/stdc++.h>
using namespace std;

int getMax(int arr[], int n) {
    int mx = arr[0];  // assume first as max
    for (int i = 1; i < n; i++)  // find maximum
        if (arr[i] > mx) mx = arr[i];
    return mx;
}

void countingSort(int arr[], int n, int exp) {
    int output[n]; // output array
    int count[10] = {0};  // count array for digits 0-9

    for (int i = 0; i < n; i++)  // count occurrences
        count[(arr[i] / exp) % 10]++;

    for (int i = 1; i < 10; i++) // cumulative count
        count[i] += count[i - 1];

    for (int i = n - 1; i >= 0; i--) { // build output (stable)
        output[count[(arr[i] / exp) % 10] - 1] = arr[i];
        count[(arr[i] / exp) % 10]--;
    }

    for (int i = 0; i < n; i++) // copy back
        arr[i] = output[i];
}

void radixSort(int arr[], int n) {
    // input: array and its size
    int m = getMax(arr, n); // get max to know digit count
    for (int exp = 1; m / exp > 0; exp *= 10) // sort by each digit
        countingSort(arr, n, exp);
    // output: sorted array
}

int main() {
    int n = 5;
    int arr[n] = {170, 45, 75, 90, 802}; // input array

    radixSort(arr, n); 

    for (int i = 0; i < n; i++)
        cout << arr[i] << " "; // expected output: 45 75 90 170 802
    return 0;
}
