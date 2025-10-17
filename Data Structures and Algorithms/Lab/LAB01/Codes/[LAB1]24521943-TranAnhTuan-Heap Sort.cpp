#include <bits/stdc++.h>
using namespace std;

void heapify(int arr[], int n, int i) {
    int largest = i; // assume root is largest
    int l = 2 * i + 1; // left child
    int r = 2 * i + 2; // right child

    if (l < n && arr[l] > arr[largest]) // if left > root
        largest = l;
    if (r < n && arr[r] > arr[largest]) // if right > largest
        largest = r;

    if (largest != i) { // if largest not root
        swap(arr[i], arr[largest]);
        heapify(arr, n, largest); // recursively heapify
    }
}

void heapSort(int arr[], int n) {
    // input: array and its size
    for (int i = n / 2 - 1; i >= 0; i--) // build max heap
        heapify(arr, n, i);
    for (int i = n - 1; i > 0; i--) { // extract elements
        swap(arr[0], arr[i]); // move max to end
        heapify(arr, i, 0); // heapify reduced heap
    }
    // output: sorted array
}

int main() {
    int n = 5;
    int arr[n] = {5, 3, 4, 1, 2}; // input array

    heapSort(arr, n);

    for (int i = 0; i < n; i++)
        cout << arr[i] << " "; // expected output: 1 2 3 4 5
    return 0;
}
