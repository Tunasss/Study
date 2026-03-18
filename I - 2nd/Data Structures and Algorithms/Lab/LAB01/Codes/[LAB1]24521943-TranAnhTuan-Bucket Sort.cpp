#include <bits/stdc++.h>
using namespace std;

void bucketSort(float arr[], int n) {
    // input: array and its size

    vector<float> buckets[n]; // create n buckets

    for (int i = 0; i < n; i++) { // put elements in buckets
        int idx = n * arr[i]; // index for bucket
        buckets[idx].push_back(arr[i]);
    }

    for (int i = 0; i < n; i++) // sort each bucket
        sort(buckets[i].begin(), buckets[i].end());

    int index = 0; // merge buckets
    for (int i = 0; i < n; i++) {
        for (float x : buckets[i])
            arr[index++] = x;
    }

    // output: sorted array
}

int main() {
    int n = 5;
    float arr[n] = {0.78, 0.17, 0.39, 0.26, 0.72};
    bucketSort(arr, n);

    for (int i = 0; i < n; i++)
        cout << arr[i] << " "; // Output: 0.17 0.26 0.39 0.72 0.78
    return 0;
}
