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

/*
Find the Next Greater Element for each element in an array.
For example, with the array a = [4, 5, 2, 25]:
The next greater element of 4 is 5.
The next greater element of 5 is 25.
The next greater element of 2 is 25.
The next greater element of 25 is -1 (no greater element).
*/


signed main()
{
    ios_base::sync_with_stdio(0); cin.tie(0);
    //freopen(file".INP","r",stdin);
    //freopen(file".OUT","w",stdout);
    int n;
    cin >> n;
    int a[N];
    FOR(i, 1, n) cin >> a[i];
    
    stack<int> s;
    int next[N];
    
    FOR(i, 1, n) {
        while (!s.empty() && a[s.top()] < a[i]) {
            next[s.top()] = a[i];
            s.pop();
        }
        s.push(i);
    }
    while (!s.empty()) {
        next[s.top()] = -1;
        s.pop();
    }

    FOR(i, 1, n) cout << "The next greater element of " << a[i] << " is " << next[i] << '\n';
    cout << '\n';

    return 0;
}