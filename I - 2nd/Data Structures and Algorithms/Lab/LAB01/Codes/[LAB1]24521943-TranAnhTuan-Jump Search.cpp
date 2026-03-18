#include <bits/stdc++.h>
using namespace std;

int jumpSearch(int arr[], int n, int target) { 
    // input: sorted array, array size, search value
    
    int step = sqrt(n); // block size
    int prev = 0;
    
    while (arr[min(step, n) - 1] < target) { // jump until value >= target
        prev = step;
        step += sqrt(n);
        if (prev >= n) return -1; // not found
    }
    
    for (int i = prev; i < min(step, n); i++) // linear search inside block
        if (arr[i] == target) 
            return i; // return index if found
    
    return -1; // return -1 if not found
    
    // output: index if found, otherwise -1
}

int main() {
    int n = 7;
    int arr[n] = {1, 3, 5, 7, 9, 11, 13};
    int target = 7;
    cout << jumpSearch(arr, n, target) << '\n'; // Output: 3
    return 0;
}
