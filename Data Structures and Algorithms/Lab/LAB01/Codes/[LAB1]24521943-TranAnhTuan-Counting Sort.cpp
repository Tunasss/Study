#include <bits/stdc++.h>
using namespace std;

void countingSort(int arr[], int n) {
    // input: array and its size

    int maxVal = *max_element(arr, arr + n); // find maximum value
    int count[maxVal + 1] = {0}; // count array

    for (int i = 0; i < n; i++) // count each element
        count[arr[i]]++;

    for (int i = 1; i <= maxVal; i++) // cumulative sum
        count[i] += count[i - 1];

    int output[n];  // output array
    for (int i = n - 1; i >= 0; i--) { // build output (stable)
        output[count[arr[i]] - 1] = arr[i];
        count[arr[i]]--;
    }

    for (int i = 0; i < n; i++) // copy back
        arr[i] = output[i];

    // output: sorted array
}

int main() {
    int n = 7;
    int arr[n] = {4, 2, 2, 8, 3, 3, 1};
    countingSort(arr, n);

    for (int i = 0; i < n; i++)
        cout << arr[i] << " "; // Output: 1 2 2 3 3 4 8
    return 0;
}
