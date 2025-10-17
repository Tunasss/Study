#include <bits/stdc++.h>
using namespace std;

void merge(int arr[], int l, int m, int r) {
    int n1 = m - l + 1, n2 = r - m;  // sizes
    int L[n1], R[n2];

    for (int i = 0; i < n1; i++) L[i] = arr[l + i]; // copy left
    for (int j = 0; j < n2; j++) R[j] = arr[m + 1 + j]; // copy right

    int i = 0, j = 0, k = l;
    while (i < n1 && j < n2) { // merge
        if (L[i] <= R[j]) arr[k++] = L[i++];
        else arr[k++] = R[j++];
    }
    while (i < n1) arr[k++] = L[i++]; // copy leftovers
    while (j < n2) arr[k++] = R[j++];
}

void mergeSort(int arr[], int l, int r) {
    // input: array, left index, right index
    if (l < r) {
        int m = (l + r) / 2;
        mergeSort(arr, l, m); // sort left half
        mergeSort(arr, m + 1, r); // sort right half
        merge(arr, l, m, r); // merge halves
    }
    // output: sorted array
}

int main() {
    int n = 5;
    int arr[n] = {5, 3, 4, 1, 2};
    mergeSort(arr, 0, n - 1);

    for (int i = 0; i < n; i++)
        cout << arr[i] << " "; // Output: 1 2 3 4 5
    return 0;
}
