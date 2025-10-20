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
struct Node {
    int data; // Value of the node
    Node *left; // Pointer to left child
    Node *right; // Pointer to right child
    Node(int val) : data(val), left(nullptr), right(nullptr) {}  // Constructor
};

Node* CreateNode(int val) { 
    Node* newNode = new Node(val); // Allocate memory for new node
    return newNode; // Return pointer to new node
}

Node* insert(Node* root, int val) {
    if (root == nullptr) { // If tree is empty → new node becomes root
        return CreateNode(val);
    }
    if (val < root->data) { // If value smaller → go to left subtree
        root->left = insert(root->left, val);
    } else if (val > root->data) { // If value greater → go to right subtree
        root->right = insert(root->right, val);
    }
    // If val == root->data → do nothing (no duplicates in BST)
    return root;
}
bool search(Node* root, int val) {
    if (root == nullptr) { // If reached null → not found
        return false;
    }
    if (root->data == val) { // Value matches current node
        return true;
    }
    if (val < root->data) { // If smaller → search in left subtree 
        return search(root->left, val);
    } else { // If greater → search in right subtree
        return search(root->right, val);
    }
}
int main() {
    int n = 8;
    int val[n] = {7, 55, 34, 87, 3, 99, 33, 21};
    Node* root = nullptr;

    FOR(i, 0, n - 1) {
        root = insert(root, val[i]);
    }

    int x = 21;

    if (search(root, x)) {
        cout << "Found\n";
    } else {
        cout << "Not found\n";
    }
    return 0;
}
