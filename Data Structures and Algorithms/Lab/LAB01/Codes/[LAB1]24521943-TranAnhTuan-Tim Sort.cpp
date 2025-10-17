#include <bits/stdc++.h>
using namespace std;
const int RUN = 32;

void insertionSort(int arr[], int left, int right) {
    // input: array, left and right bounds of subarray

    for (int i = left + 1; i <= right; i++) {
        int key = arr[i]; // take current element
        int j = i - 1;

        // shift elements larger than key
        while (j >= left && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key; // insert key at correct place
    }
    // output: sorted subarray
}

void merge(int arr[], int l, int m, int r) {
    int n1 = m - l + 1, n2 = r - m; // sizes of subarrays
    int L[n1], R[n2]; // temp arrays

    for (int i = 0; i < n1; i++) L[i] = arr[l + i]; // copy left half
    for (int j = 0; j < n2; j++) R[j] = arr[m + 1 + j]; // copy right half

    int i = 0, j = 0, k = l;
    while (i < n1 && j < n2) { // merge step
        if (L[i] <= R[j]) arr[k++] = L[i++];
        else arr[k++] = R[j++];
    }
    while (i < n1) arr[k++] = L[i++]; // copy remaining L
    while (j < n2) arr[k++] = R[j++]; // copy remaining R
}

void timSort(int arr[], int n) {
    // input: array and its size

    // sort small subarrays using Insertion Sort
    for (int i = 0; i < n; i += RUN)
        insertionSort(arr, i, min(i + RUN - 1, n - 1));

    // merge sorted runs using Merge Sort
    for (int size = RUN; size < n; size = 2 * size) {
        for (int left = 0; left < n; left += 2 * size) {
            int mid = min(left + size - 1, n - 1);
            int right = min(left + 2 * size - 1, n - 1);
            if (mid < right) merge(arr, left, mid, right);
        }
    }
    // output: sorted array
}

int main() {
    int n = 5;
    int arr[n] = {5, 21, 7, 23, 19}; 
    
    timSort(arr, n); 

    for (int i = 0; i < n; i++)
        cout << arr[i] << " "; // expected output: 5 7 19 21 23
    return 0;
}
