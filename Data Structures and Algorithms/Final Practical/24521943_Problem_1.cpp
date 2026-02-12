// 24521943 - Tran Anh Tuan

#include <bits/stdc++.h>
using namespace std;
typedef long long ll;;

const ll N = 1e5 + 5;
int arr[N];
int n;

int partition(int arr[], int low, int high) {
    int pivot = arr[high];
    int i = low - 1;
    for (int j = low; j < high; j++) {
        if (arr[j] <= pivot) {
            i++;
            swap(arr[i], arr[j]);
        }
    }
    swap(arr[i + 1], arr[high]);
    return i + 1;
}

void quickSort(int arr[], int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }

}

signed main()
{
    ios_base::sync_with_stdio(0); cin.tie(0);

    cin >> n;
    for (int i = 1; i <= n; i++){
        cin >> arr[i];
    }
    quickSort(arr, 1 ,n);
    for (int i = n; i >= 1; i--){
        cout << arr[i] << ' ';
    }
}
