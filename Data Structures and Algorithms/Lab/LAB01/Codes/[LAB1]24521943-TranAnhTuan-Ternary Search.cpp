#include <bits/stdc++.h>
using namespace std;

int ternarySearch(int arr[], int l, int r, int target) {
	// input: sorted array, left index, right index, search value

	while (r >= l) {
		int mid1 = l + (r - l) / 3; // first mid
		int mid2 = r - (r - l) / 3; // second mid

		if (arr[mid1] == target) return mid1; // return index if found at mid1
		if (arr[mid2] == target) return mid2; // return index if found at mid2

		if (target < arr[mid1]) r = mid1 - 1; // search left part
		else if (target > arr[mid2]) l = mid2 + 1; // search right part
		else { l = mid1 + 1; r = mid2 - 1; } // search middle part
	}

	return -1; // return -1 if not found

	// output: index if found, otherwise -1
}

int main() {
	int n = 6;
	int arr[n] = {1, 3, 5, 7, 9, 11};
	int target = 7;

	cout << ternarySearch(arr, 0, n - 1, target) << '\n'; // Output: 3
	return 0;
}
