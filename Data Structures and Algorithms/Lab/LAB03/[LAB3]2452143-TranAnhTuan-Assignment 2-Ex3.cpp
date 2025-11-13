#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
typedef unsigned long long ull;
typedef string str;
typedef pair <int, int> ii;
#define file "TEST"
#define st first
#define nd second
#define pb push_back
#define lb lower_bound
#define ub upper_bound
#define vll vector<ll>
#define vi vector<int>
#define all(v) (v).begin(), (v).end()
#define FOR(i,x,y) for(ll i = x; i <= y; ++i)
#define FOS(i,x,y) for(ll i = x; i >= y; --i)
#define EACH(i,x) for (auto &(i) : (x))
#define el cout << '\n';
const ll MOD = 1e9 + 7;
#define dbg(...) cerr << "[" << #__VA_ARGS__ ": " << (__VA_ARGS__) << "]  "
#define dbge(...) cerr << "[" << #__VA_ARGS__ ": " << (__VA_ARGS__) << "]" << endl;

/*
mt19937_64 rd(chrono::steady_clock::now().time_since_epoch().count());
ll rand(ll l, ll r) { return uniform_int_distribution<ll>(l, r)(rd); }
*/

int sumDiagonal(int** arr, int m, int n) {
    int sum = 0;
    for (int i = 0; i < min(m, n); i++) {
        sum += arr[i][i];
    }
    return sum;
}

int maxBoundary(int** arr, int m, int n) {
    int maxVal = INT_MIN;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (i == 0 || i == m - 1 || j == 0 || j == n - 1) {
                maxVal = max(maxVal, arr[i][j]);
            }
        }
    }
    return maxVal;
}


signed main()
{
    ios_base::sync_with_stdio(0); cin.tie(0);
    //freopen(file".INP","r",stdin);
    //freopen(file".OUT","w",stdout);

    int m, n;
    cin >> m >> n;

    int **a = new int*[m];
    for (int i = 0; i < m; ++i) a[i] = new int[n];

    for (int i = 0; i < m; ++i)
        for (int j = 0; j < n; ++j)
            cin >> a[i][j];
            
    cout << "Sum of main diagonal: " << sumDiagonal(a, m, n) << endl;
    cout << "Maximum element on the boundary: " << maxBoundary(a, m, n) << endl;

    for (int i = 0; i < m; ++i) delete[] a[i];
    delete[] a;

    return 0;
}