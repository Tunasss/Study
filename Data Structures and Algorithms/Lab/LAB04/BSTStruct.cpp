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
#define MAX_NODES 100

struct Node {
    int data;
    int left;
    int right; 
};

class BST {
private:
    Node nodes[MAX_NODES];
    int rootIndex;
    int nodeCount;

    int insert(int index, int value) {
        if (index == -1) {
            nodes[nodeCount].data = value;
            nodes[nodeCount].left = -1;
            nodes[nodeCount].right = -1;
            return nodeCount++;
        }
        if (value < nodes[index].data) {
            nodes[index].left = insert(nodes[index].left, value);
        } else {
            nodes[index].right = insert(nodes[index].right, value);
        }
        return index;
    }

    bool search(int index, int value) {
        if (index == -1) return false;
        if (nodes[index].data == value) return true;
        if (value < nodes[index].data) {
            return search(nodes[index].left, value);
        } else {
            return search(nodes[index].right, value);
        }
    }
    void inorder(int index) {
        if (index == -1) return;
        inorder(nodes[index].left);
        cout << nodes[index].data << " ";
        inorder(nodes[index].right);
    }
    void preorder(int index) {
        if (index == -1) return;
        cout << nodes[index].data << " ";
        preorder(nodes[index].left);
        preorder(nodes[index].right);
    }
    void postorder(int index) {
        if (index == -1) return;
        postorder(nodes[index].left);
        postorder(nodes[index].right);
        cout << nodes[index].data << " ";
    }
public:
    BST() : rootIndex(-1), nodeCount(0) {}
    void Insert(int value) {
        rootIndex = insert(rootIndex, value);
    }
    bool Search(int value) {
        return search(rootIndex, value);
    }
    void Inorder() {
        inorder(rootIndex);
        cout << endl;
    }
    void Preorder() {
        preorder(rootIndex);
        cout << endl;
    }
    void Postorder() {
        postorder(rootIndex);
        cout << endl;
    }
};  

int main() {
    BST tree;
    tree.Insert(50);
    tree.Insert(30);
    tree.Insert(70);
    tree.Insert(20);
    tree.Insert(40);
    tree.Insert(60);
    tree.Insert(80);

    cout << "Inorder Traversal: ";
    tree.Inorder();

    cout << "Preorder Traversal: ";
    tree.Preorder();

    cout << "Postorder Traversal: ";
    tree.Postorder();

    int searchValue = 40;
    if (tree.Search(searchValue)) {
        cout << searchValue << " found in the BST." << endl;
    } else {
        cout << searchValue << " not found in the BST." << endl;
    }

    return 0;
}