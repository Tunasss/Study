#include <bits/stdc++.h>
using namespace std;

void selectionSort(int arr[], int n) { 
    // input: array and its size

    for (int i = 0; i < n - 1; i++) { // move boundary of unsorted part
        int minIdx = i; // assume current element is the minimum
        for (int j = i + 1; j < n; j++) { // find the smallest element in unsorted part
            if (arr[j] < arr[minIdx])
                minIdx = j; // update minIdx if smaller element found
        }
        swap(arr[i], arr[minIdx]); // place minimum at the beginning of unsorted part
    }
    // output: sorted array
}

int main() {
    int n = 5;
    int arr[n] = {5, 3, 4, 1, 2}; // input array

    selectionSort(arr, n); // sort the array

    for (int i = 0; i < n; i++)
        cout << arr[i] << " ";  // expected output: 1 2 3 4 5
    return 0;
}
