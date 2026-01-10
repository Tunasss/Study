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

int n, m;
vector<vector<ii>> adj;
vector<ll> dist;
vector<int> parent;

void Dijkstra(int s) {
    dist.assign(n, oo);
    parent.assign(n, -1);
    dist[s] = 0;
    
    priority_queue<ii, vector<ii>, greater<ii>> pq;
    pq.push({0, s});

    while (!pq.empty()) {
        ii top = pq.top(); pq.pop();
        ll d = top.st;
        int u = top.nd;

        if (d > dist[u]) continue;

        for (ii edge : adj[u]) {
            int v = edge.st;
            ll w = edge.nd;

            if (dist[u] + w < dist[v]) {
                dist[v] = dist[u] + w;
                parent[v] = u; 
                pq.push({dist[v], v});
            }
        }
    }
}

int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    cout << "Nhap so dinh n: ";
    cin >> n;
    cout << "Nhap so canh m: ";
    cin >> m;
    
    adj.resize(n);
    cout << "Nhap " << m << " canh (u v w):\n";
    for (int i = 0; i < m; ++i) {
        int u, v;
        ll w;
        cin >> u >> v >> w;
        adj[u].pb({v, w});
        //adj[v].pb({u, w}); 
    }

    Dijkstra(0);

    int t;
    cout << "\nNhap dinh dich: ";
    cin >> t;

    cout << endl;
    if (dist[t] == oo) {
        cout << "Khong co duong di tu 0 den " << t << endl;
    } else {
        vector<int> path;
        int curr = t;
        while (curr != -1) {
            path.pb(curr);
            curr = parent[curr];
        }
        reverse(path.begin(), path.end()); 

        cout << "Shortest path 0 -> " << t << ": ";
        for (int i = 0; i < path.size(); ++i) {
            cout << path[i] << (i < path.size() - 1 ? " " : "");
        }
        cout << "\nCost: " << dist[t] << endl;
    }

    return 0;
}