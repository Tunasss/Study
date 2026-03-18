#include <bits/stdc++.h>
using namespace std;

void insertionSort(int arr[], int n) {
    // input: array and its size
    
    for (int i = 1; i < n; i++) {// loop through elements starting from index 1
        int key = arr[i]; // store current element
        int j = i - 1;
        while (j >= 0 && arr[j] > key){ // shift elements greater than key
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key; // insert key at the correct position
    }
    // output: sorted array
}

int main() {
    int n = 5;
    int arr[n] = {5, 3, 4, 1, 2}; // input array

    insertionSort(arr, n);

    for (int i = 0; i < n; i++){
        cout << arr[i] << " "; // expected output: 1 2 3 4 5
    }
    return 0;
}
