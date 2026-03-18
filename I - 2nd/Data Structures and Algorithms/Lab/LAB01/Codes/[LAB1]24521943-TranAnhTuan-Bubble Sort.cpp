#include <bits/stdc++.h>
using namespace std;

void bubbleSort(int arr[], int n) {
    // input: array and its size

    for (int i = 0; i < n - 1; i++) {              // loop for each pass
        for (int j = 0; j < n - i - 1; j++) {      // compare adjacent elements
            if (arr[j] > arr[j + 1])               // swap if out of order
                swap(arr[j], arr[j + 1]);
        }
    }
    // output: sorted array
}

int main() {
    int n = 5;
    int arr[n] = {5, 3, 4, 1, 2}; // input array

    bubbleSort(arr, n); 

    for (int i = 0; i < n; i++) 
        cout << arr[i] << " "; // expected output: 1 2 3 4 5
    return 0;
}
