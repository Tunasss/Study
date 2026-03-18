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

//#define int long long
const ll N = 2e5 + 5;


signed main()
{
    ios_base::sync_with_stdio(0); cin.tie(0);
    //freopen(file".INP","r",stdin);
    //freopen(file".OUT","w",stdout);
    int m, n;
    cin >> m >> n;
    
    int** a = new int*[m];
    for (int i = 0; i < m; ++i) a[i] = new int[n];

    for (int i = 0; i < m; ++i)
        for (int j = 0; j < n; ++j)
            cin >> a[i][j];

    int** b = new int*[n];
    for (int i = 0; i < n; ++i) b[i] = new int[m];

    for (int i = 0; i < m; ++i)
        for (int j = 0; j < n; ++j)
            b[j][i] = a[i][j];

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j)
            cout << b[i][j] << ' ';
        cout << '\n';
    }

    for (int i = 0; i < n; ++i) delete[] b[i];

    return 0;
}
