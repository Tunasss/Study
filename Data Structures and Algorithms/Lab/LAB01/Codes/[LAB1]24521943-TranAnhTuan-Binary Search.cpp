#include <bits/stdc++.h>
using namespace std;

int binarySearch(int arr[], int n, int target) {
    // input: sorted array, array size, search value
    int left = 0, right = n - 1;

    while (left <= right) { // search until range is valid
        int mid = (left + right) / 2; // middle index
        if (arr[mid] == target)       // found target
            return mid;
        else if (arr[mid] < target)   // target is in right half
            left = mid + 1;
        else                          // target is in left half
            right = mid - 1;
    }
    return -1; // not found
    // output: index if found, otherwise -1
}

int main() {
    int n = 6;
    int arr[n] = {-17, -14, -5, 1, 2, 3}; // sorted array
    int target;

    target = 1;
    cout << binarySearch(arr, n, target) << '\n'; // Output: 3

    return 0;
}
