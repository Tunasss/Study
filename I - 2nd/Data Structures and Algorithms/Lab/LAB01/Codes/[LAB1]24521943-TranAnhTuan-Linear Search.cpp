#include <bits/stdc++.h>

using namespace std;

int linearSearch(int arr[], int n, int target) { 
    // input: array, array size, search value
    
    for (int i = 0; i < n; i++) {// loop through each element
        if (arr[i] == target) { // check if current element matches target
            return i;// return index if found
        }
    }
    return -1 // return -1 if not found
    
    // output: index if found, otherwise -1
}

int main() {
    int n = 6;
    int arr[n] = {-14, -5, 1, 3, -17, 2};
    int target;

    target = 3;
    cout << linearSearch(arr, n, target) << '\n'; // Output: 3

    return 0;
}
