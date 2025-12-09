#include <bits/stdc++.h>

using namespace std;

class Graph {
    map<char, vector<char>> adjList;

public:
    void addEdge(char u, char v) {
        adjList[u].push_back(v);
    }

    void printPath(char start, char target, map<char, char>& parent) {
        if (parent.find(target) == parent.end() && start != target) {
            cout << "No path found from " << start << " to " << target << endl;
            return;
        }

        vector<char> path;
        char curr = target;
        while (curr != start) {
            path.push_back(curr);
            curr = parent[curr];
        }
        path.push_back(start);
        reverse(path.begin(), path.end());

        cout << "Path found: ";
        for (int i = 0; i < path.size(); i++) {
            cout << path[i] << (i < path.size() - 1 ? " -> " : "");
        }
        cout << endl;
    }

    void DFS(char start, char goal) {
        cout << "\n--- DFS Algorithm (Target: " << goal << ") ---" << endl;
        
        stack<char> s;
        set<char> visited;
        map<char, char> parent;

        s.push(start);

        while (!s.empty()) {
            char current = s.top();
            s.pop();

            if (visited.find(current) == visited.end()) {
                visited.insert(current);
                cout << "Visiting: " << current << endl;

                if (current == goal) {
                    printPath(start, goal, parent);
                    return;
                }
                if (adjList.find(current) != adjList.end()) {
                    vector<char> neighbors = adjList[current];
                    reverse(neighbors.begin(), neighbors.end()); 
                    
                    for (char neighbor : neighbors) {
                        if (visited.find(neighbor) == visited.end()) {
                            s.push(neighbor);
                            parent[neighbor] = current;
                        }
                    }
                }
            }
        }
        cout << "Target not found." << endl;
    }

    void BFS(char start, char goal) {
        cout << "\n--- BFS Algorithm (Target: " << goal << ") ---" << endl;

        queue<char> q;
        set<char> visited;
        map<char, char> parent;

        q.push(start);
        visited.insert(start);

        while (!q.empty()) {
            char current = q.front();
            q.pop();

            cout << "Visiting: " << current << endl;

            if (current == goal) {
                printPath(start, goal, parent);
                return;
            }

            if (adjList.find(current) != adjList.end()) {
                for (char neighbor : adjList[current]) {
                    if (visited.find(neighbor) == visited.end()) {
                        q.push(neighbor);
                        visited.insert(neighbor);
                        parent[neighbor] = current;
                    }
                }
            }
        }
        cout << "Target not found." << endl;
    }
};

int main() {
    Graph g;

    g.addEdge('A', 'B');
    g.addEdge('A', 'C');
    g.addEdge('A', 'D');
    g.addEdge('A', 'E');

    g.addEdge('B', 'F');
    g.addEdge('F', 'H');

    g.addEdge('D', 'G');
    g.addEdge('G', 'I');
    
    g.DFS('A', 'H');

    g.BFS('A', 'G');

    return 0;
}