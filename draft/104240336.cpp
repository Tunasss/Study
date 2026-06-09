#include <bits/stdc++.h>
using namespace std;

const int INF = 1e9;

string trim(const string& str) {
    size_t first = str.find_first_not_of(" \t\r\n");
    if (first == string::npos) return "";
    size_t last = str.find_last_not_of(" \t\r\n");
    return str.substr(first, (last - first + 1));
}

struct Edge {
    int to;
    int weight;
};

struct HeapNode {
    int time;
    int vertex;
};

class MinHeap {
private:
    vector<HeapNode> heap;
    vector<int> pos;

    void heapifyUp(int idx) {
        while (idx > 0) {
            int parent = (idx - 1) / 2;
            if (heap[idx].time < heap[parent].time) {
                swap(pos[heap[idx].vertex], pos[heap[parent].vertex]);
                swap(heap[idx], heap[parent]);
                idx = parent;
            } else {
                break;
            }
        }
    }

    void heapifyDown(int idx) {
        int n = heap.size();
        while (2 * idx + 1 < n) {
            int left = 2 * idx + 1;
            int right = 2 * idx + 2;
            int smallest = left;
            if (right < n && heap[right].time < heap[left].time) {
                smallest = right;
            }
            if (heap[smallest].time < heap[idx].time) {
                swap(pos[heap[smallest].vertex], pos[heap[idx].vertex]);
                swap(heap[smallest], heap[idx]);
                idx = smallest;
            } else {
                break;
            }
        }
    }

public:
    MinHeap(int max_vertices) {
        pos.assign(max_vertices, -1);
    }

    bool empty() {
        return heap.empty();
    }

    void pushOrDecrease(int vertex, int time) {
        if (pos[vertex] == -1) {
            HeapNode node = {time, vertex};
            heap.push_back(node);
            int idx = heap.size() - 1;
            pos[vertex] = idx;
            heapifyUp(idx);
        } else {
            int idx = pos[vertex];
            if (time < heap[idx].time) {
                heap[idx].time = time;
                heapifyUp(idx);
            }
        }
    }

    HeapNode extractMin() {
        HeapNode root = heap[0];
        HeapNode last = heap.back();
        heap.pop_back();
        if (!heap.empty()) {
            heap[0] = last;
            pos[heap[0].vertex] = 0;
            heapifyDown(0);
        }
        pos[root.vertex] = -1;
        return root;
    }
};

void solveGraph(int n, int src_idx, int dest_idx, const vector<int>& vertex_cycles, 
                const vector<vector<Edge>>& adj, const vector<string>& vertex_names) {
    vector<int> min_time(n, INF);
    vector<int> parent(n, -1);
    vector<bool> visited(n, false);

    MinHeap pq(n);

    min_time[src_idx] = 0;
    pq.pushOrDecrease(src_idx, 0);

    while (!pq.empty()) {
        HeapNode curr = pq.extractMin();
        int u = curr.vertex;
        int time_u = curr.time;

        if (visited[u]) continue;
        visited[u] = true;

        if (u == dest_idx) break;

        int departure_time = time_u;
        if (u != src_idx && time_u > 30) {
            int t_u = vertex_cycles[u];
            if (time_u % t_u != 0) {
                departure_time = time_u + (t_u - (time_u % t_u));
            }
        }

        for (const auto& edge : adj[u]) {
            int v = edge.to;
            int w = edge.weight;

            if (visited[v]) continue;

            int arr_time = departure_time + w;

            if (arr_time < min_time[v]) {
                min_time[v] = arr_time;
                parent[v] = u;
                pq.pushOrDecrease(v, arr_time);
            }
        }
    }

    if (min_time[dest_idx] == INF) {
        cout << "0\n";
        return;
    }

    cout << min_time[dest_idx] << "\n";
    cerr << min_time[dest_idx] << "\n";

    vector<string> path;
    int curr = dest_idx;
    while (curr != -1) {
        path.push_back(vertex_names[curr]);
        curr = parent[curr];
    }
    reverse(path.begin(), path.end());

    for (size_t i = 0; i < path.size(); ++i) {
        cout << path[i] << " ";
        cerr << path[i] << " ";
    }
    cout << "\n";
    cerr << "\n";
}

int main(int argc, char* argv[]) {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    if (argc < 3) {
        cerr << "Usage: " << argv[0] << " <input_file> <output_file>\n";
        return 1;
    }

    string input_filename = argv[1];
    string output_filename = argv[2];

    if (!freopen(input_filename.c_str(), "r", stdin)) {
        cerr << "Error opening input file: " << input_filename << "\n";
        return 1;
    }

    if (!freopen(output_filename.c_str(), "w", stdout)) {
        cerr << "Error opening output file: " << output_filename << "\n";
        return 1;
    }

    vector<string> lines;
    string line;

    while (getline(cin, line)) {
        lines.push_back(line);
    }

    size_t line_idx = 0;
    if (line_idx >= lines.size()) return 0;

    int num_graphs = stoi(trim(lines[line_idx++]));

    for (int g = 0; g < num_graphs; ++g) {
        while (line_idx < lines.size() && trim(lines[line_idx]).empty()) {
            line_idx++;
        }
        if (line_idx >= lines.size()) break;

        int n = stoi(trim(lines[line_idx++]));

        vector<string> vertex_names;
        vector<int> vertex_cycles;
        unordered_map<string, int> vertex_to_index;

        for (int i = 0; i < n; ++i) {
            if (line_idx >= lines.size()) {
                cerr << "Unexpected end of file in graph " << g + 1 << "\n";
                return 1;
            }
            string v_line = lines[line_idx++];
            stringstream ss(v_line);
            string v_name;
            string v_cycle_str;

            getline(ss, v_name, ',');
            getline(ss, v_cycle_str, ',');

            v_name = trim(v_name);
            int v_cycle = stoi(trim(v_cycle_str));

            vertex_to_index[v_name] = i;
            vertex_names.push_back(v_name);
            vertex_cycles.push_back(v_cycle);
        }

        vector<vector<Edge>> adj(n);

        while (line_idx < lines.size() && lines[line_idx].find(',') != string::npos) {
            string e_line = lines[line_idx++];
            stringstream ss(e_line);
            string u_name, v_name, weight_str;

            getline(ss, u_name, ',');
            getline(ss, v_name, ',');
            getline(ss, weight_str, ',');

            u_name = trim(u_name);
            v_name = trim(v_name);
            int weight = stoi(trim(weight_str));

            auto it_u = vertex_to_index.find(u_name);
            auto it_v = vertex_to_index.find(v_name);

            if (it_u != vertex_to_index.end() && it_v != vertex_to_index.end()) {
                int u_idx = it_u->second;
                int v_idx = it_v->second;
                adj[u_idx].push_back({v_idx, weight});
                adj[v_idx].push_back({u_idx, weight});
            }
        }

        auto it_A = vertex_to_index.find("A");
        auto it_G = vertex_to_index.find("G");

        if (it_A != vertex_to_index.end() && it_G != vertex_to_index.end()) {
            solveGraph(n, it_A->second, it_G->second, vertex_cycles, adj, vertex_names);
        } else {
            cout << "0\n";
        }
    }

    return 0;
}