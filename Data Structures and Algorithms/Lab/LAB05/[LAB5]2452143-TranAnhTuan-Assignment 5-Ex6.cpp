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
vector<int> topo;
list<int> d[N];
int c[N];
 
bool check(int v, bool visit[], bool *rec)
{ 
    if (!visit[v])
    {
        visit[v] = 1;
        rec[v] = 1;
        list<int>::iterator i;
        for (i = d[v].begin(); i != d[v].end(); ++i)
        {
            if (!visit[*i] && check(*i, visit, rec))
                return true;
            else if (rec[*i])
                return true;
        }
 
    }
    rec[v] = false;  
    return false;
}
bool isCyclic()
{
    bool visit[N];
    bool rec[N];
    for (int i = 0; i < n; i++){
        visit[i] = false;
        rec[i] = false;
    }
    for (int i = 0; i < n; i++)
        if (check(i, visit, rec))
            return true;
 
    return false;
}
 
void dfs(int i) {
    if (c[i])
        return;
    c[i] = 1;
    for (int j : d[i])
        dfs(j);
    topo.pb(i);
}
 
int main() {
    ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0);

    cout << "Nhap so dinh n: ";
    cin >> n;
    cout << "Nhap so canh m: ";
    cin >> m;

    cout << "Nhap " << m << " canh (u v):\n";
    for (int i = 0; i < m; ++i) {
        int u, v;
        cin >> u >> v;
        d[u].pb(v);
    }

    if(isCyclic()){
        cout << "Do thi CHU TRINH! Khong the sap xep topo.\n";
        return 0;
    }
 
    for (int i = 0; i < n; ++i)
        dfs(i);
 
    reverse(topo.begin(), topo.end());
    
    cout << "Thu tu sap xep to-po (Topological Order): \n";

    //Print toporder with pointer after each element
    for (int v : topo)
        cout << v << " -> ";
    el;
    return 0;
}