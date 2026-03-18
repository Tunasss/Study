// 24521943 - Tran Anh Tuan

#include <bits/stdc++.h>
using namespace std;
typedef long long ll;

//#define int long long
const ll N = 2e5 + 5;

void dfs(int u, int p, vector<bool>& visited, const vector<vector<int>>& adj, vector<int>& result) {
    visited[u] = true;
    result.push_back(u);
    for (int v : adj[u]) {
        if (!visited[v]) {
            dfs(v, u, visited, adj, result);
        }
    }
}
	
void dfs_backtrack(int u, int p, vector<bool>& visited, const vector<vector<int>>& adj, vector<int>& result, bool printTrace) {
    visited[u] = true;
    result.push_back(u);

    if (printTrace) {
        if (u == 0) {
            cout << "Start at " << u << ": Mark as visited. Print " << u << "." << endl;
        } else {
            cout << "Move to " << u << ": Mark as visited. Print " << u << ".";
        }
    }

    bool isLeaf = true;
    
    for (int v : adj[u]) {
        if (!visited[v]) {
            if (printTrace && u != 0) cout << endl;
            isLeaf = 0;
            dfs_backtrack(v, u, visited, adj, result, printTrace);
        }
    }
}

signed main()
{
    ios_base::sync_with_stdio(0); cin.tie(0);

    vector<vector<int>> adj = { {1, 2}, {0, 2}, {0, 1, 3, 4}, {2}, {2} };

    int n = adj.size();
    vector<bool> visited(n, 0);
    vector<int> result;

    cout << "\nOutput: ";
    dfs(0, -1, visited, adj, result);

    for (int i = 0; i < result.size(); i++) {
        cout << result[i] << " ";
    }

    cout << "\nExplanation:" << endl;
    vector<bool> visited_bt(n, 0);
    vector<int> result_bt;

    dfs_backtrack(0, -1, visited_bt, adj, result_bt, true);
}
