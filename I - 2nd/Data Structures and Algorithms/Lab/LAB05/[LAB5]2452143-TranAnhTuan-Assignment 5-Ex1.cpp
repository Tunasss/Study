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
#define er equal_range
#define bin binary_search
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

const ll N = 5e3 + 5;
const ll oo = 2e15 + 5;

int main() {
    int n, m;
    cout << "Nhap so dinh n: ";
    cin >> n;
    cout << "Nhap so canh m: ";
    cin >> m;
    cout << "Nhap " << m << " canh (u v):" << endl;

    int a[n + 1][n + 1];
    memset(a, 0, sizeof(a));

    for (int i = 0; i < m; ++i) {
        int u, v;
        cin >> u >> v;
        a[u][v] = a[v][u] = 1;
    }

    cout << "Ma tran ke " << n << " x " << n << ":" << endl;
    cout << "  ";
    for (int j = 0; j < n; ++j) {
        if (j) cout << " ";
        cout << j;
    }
    cout << endl;
    for (int i = 0; i < n; ++i) {
        cout << i;
        for (int j = 0; j < n; ++j) {
            cout << " " << a[i][j];
        }
        cout << endl;
    }
    return 0;
}