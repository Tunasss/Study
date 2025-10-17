#include <bits/stdc++.h>
using namespace std;

int partition(int arr[], int low, int high) {
    int pivot = arr[high]; // choose last element as pivot
    int i = low - 1; // index of smaller element
    for (int j = low; j < high; j++) { // traverse array
        if (arr[j] <= pivot) { // if current element <= pivot
            i++;
            swap(arr[i], arr[j]); // place smaller element on left
        }
    }
    swap(arr[i + 1], arr[high]); // place pivot in correct position
    return i + 1; // return pivot index
}

void quickSort(int arr[], int low, int high) {
    // input: array, left index, right index
    if (low < high) {
        int pi = partition(arr, low, high); // partition index
        quickSort(arr, low, pi - 1); // recursively sort left
        quickSort(arr, pi + 1, high); // recursively sort right
    }
    // output: sorted array
}

int main() {
    int n = 5;
    int arr[n] = {5, 3, 4, 1, 2}; // input array

    quickSort(arr, 0, n - 1); 

    for (int i = 0; i < n; i++) 
        cout << arr[i] << " "; // expected output: 1 2 3 4 5
    return 0;
}
