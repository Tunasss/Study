#include <bits/stdc++.h>
using namespace std;

int interpolationSearch(int arr[], int n, int target) { 
    // input: sorted array, array size, search value

    int low = 0, high = n - 1;
    while (low <= high && target >= arr[low] && target <= arr[high]) {
        if (low == high) {
            if (arr[low] == target) return low;
            return -1;
        }
        // estimate position
        int pos = low + ((double)(high - low) / (arr[high] - arr[low])) * (target - arr[low]);
        
        if (arr[pos] == target) return pos; // return index if found
        if (arr[pos] < target) low = pos + 1; // search right
        else high = pos - 1; // search left
    }
    return -1; // return -1 if not found

    // output: index if found, otherwise -1
}

int main() {
    int n = 5;
    int arr[n] = {10, 20, 30, 40, 50};
    int target = 30;

    cout << interpolationSearch(arr, n, target) << '\n'; // Output: 2
    return 0;
}
