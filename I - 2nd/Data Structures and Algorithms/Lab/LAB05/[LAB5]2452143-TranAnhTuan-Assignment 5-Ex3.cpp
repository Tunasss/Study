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
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cout << "Nhap so dinh n: ";
    cin >> n;
    cout << "Nhap so canh m: ";
    cin >> m;

    vector<vector<int>> adj(n);
    cout << "Nhap " << m << " canh (u v):\n";
    for (int i = 0; i < m; ++i) {
        int u, v;
        cin >> u >> v;
        adj[u].push_back(v);
        adj[v].push_back(u);
    }

    for (int i = 0; i < n; ++i) {
        sort(adj[i].begin(), adj[i].end());
    }

    vector<bool> visited(n, false);
    vector<int> order;
    function<void(int)> dfs = [&](int u) {
        visited[u] = true;
        order.push_back(u);
        for (int v : adj[u]) {
            if (!visited[v]) dfs(v);
        }
    };

    if (n > 0) dfs(0);

    cout << "Thu tu duyet DFS tu dinh 0: ";
    for (size_t i = 0; i < order.size(); ++i) {
        if (i) cout << ' ';
        cout << order[i];
    }
    cout << '\n';
    return 0;
}