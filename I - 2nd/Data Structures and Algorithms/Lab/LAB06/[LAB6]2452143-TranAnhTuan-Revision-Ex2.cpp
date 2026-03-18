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


int main() {
    ios::sync_with_stdio(0);
    cin.tie(0);

    int n;
    cin >> n;
    queue<int> q1, q2;

    FOR(i,1,n) {
        int x; cin >> x;
        q1.push(x);
    }

    int remaining = n;
    while (remaining > 0) {
        int mn = INT_MAX;
        for (int i = 0; i < remaining; ++i) {
            int x = q1.front(); q1.pop();
            if (x < mn) mn = x;
            q1.push(x);
        }

        bool removed = false;
        for (int i = 0; i < remaining; ++i) {
            int x = q1.front(); q1.pop();
            if (x == mn && !removed) {
                removed = true;
            } else {
                q1.push(x);
            }
        }

        q2.push(mn);
        --remaining;
    }

    bool first = true;
    while (!q2.empty()) {
        if (!first) cout << ' ';
        first = false;
        cout << q2.front();
        q2.pop();
    }
    el
    return 0;
}
