#include <bits/stdc++.h>
using namespace std;

int binarySearch(int arr[], int left, int right, int target) {
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] == target) return mid; // return index if found
        if (arr[mid] < target) left = mid + 1; 
        else right = mid - 1;
    }
    return -1; // not found
}

int exponentialSearch(int arr[], int n, int target) { 
    // input: sorted array, array size, search value
    
    if (arr[0] == target) return 0;

    int i = 1;
    while (i < n && arr[i] <= target)
        i *= 2; // find range

    return binarySearch(arr, i/2, min(i, n-1), target); // search in range
    
    // output: index if found, otherwise -1
}

int main() {
    int n = 7;
    int arr[n] = {1, 2, 3, 4, 5, 6, 7};
    int target = 6;

    cout << exponentialSearch(arr, n, target) << '\n'; // Output: 5
    return 0;
}
