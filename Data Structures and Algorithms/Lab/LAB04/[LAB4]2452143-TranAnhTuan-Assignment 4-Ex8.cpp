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
    ll key;
    Node *left, *right, *parent;
    Node(ll k): key(k), left(nullptr), right(nullptr), parent(nullptr) {}
};

struct BST {
    Node *root;
    BST(): root(nullptr) {}
    ~BST() { clear(root); }

    void clear(Node* x) {
        if (!x) return;
        clear(x->left);
        clear(x->right);
        delete x;
    }

    Node* search(Node* x, ll key) {
        if (!x || x->key == key) return x;
        if (key < x->key) return search(x->left, key);
        return search(x->right, key);
    }
    Node* search(ll key) { return search(root, key); }

    Node* iterativeSearch(ll key) {
        Node* cur = root;
        while (cur && cur->key != key) {
            cur = (key < cur->key) ? cur->left : cur->right;
        }
        return cur;
    }

    void insert(ll key) {
        Node *y = nullptr;
        Node *x = root;
        while (x) {
            y = x;
            if (key < x->key) x = x->left;
            else x = x->right;
        }
        Node* z = new Node(key);
        z->parent = y;
        if (!y) root = z;
        else if (key < y->key) y->left = z;
        else y->right = z;
    }

    void transplant(Node* u, Node* v) {
        if (!u->parent) root = v;
        else if (u == u->parent->left) u->parent->left = v;
        else u->parent->right = v;
        if (v) v->parent = u->parent;
    }

    Node* minimum(Node* x) {
        if (!x) return nullptr;
        while (x->left) x = x->left;
        return x;
    }
    Node* maximum(Node* x) {
        if (!x) return nullptr;
        while (x->right) x = x->right;
        return x;
    }
    Node* minimum() { return minimum(root); }
    Node* maximum() { return maximum(root); }

    Node* successor(Node* x) {
        if (!x) return nullptr;
        if (x->right) return minimum(x->right);
        Node* y = x->parent;
        while (y && x == y->right) {
            x = y;
            y = y->parent;
        }
        return y;
    }

    Node* predecessor(Node* x) {
        if (!x) return nullptr;
        if (x->left) return maximum(x->left);
        Node* y = x->parent;
        while (y && x == y->left) {
            x = y;
            y = y->parent;
        }
        return y;
    }

    bool remove(ll key) {
        Node* z = search(key);
        if (!z) return false;
        if (!z->left) transplant(z, z->right);
        else if (!z->right) transplant(z, z->left);
        else {
            Node* y = minimum(z->right);
            if (y->parent != z) {
                transplant(y, y->right);
                y->right = z->right;
                if (y->right) y->right->parent = y;
            }
            transplant(z, y);
            y->left = z->left;
            if (y->left) y->left->parent = y;
        }
        delete z;
        return true;
    }

    void inorder(Node* x, vector<ll>& out) {
        if (!x) return;
        inorder(x->left, out);
        out.push_back(x->key);
        inorder(x->right, out);
    }
    void preorder(Node* x, vector<ll>& out) {
        if (!x) return;
        out.push_back(x->key);
        preorder(x->left, out);
        preorder(x->right, out);
    }
    void postorder(Node* x, vector<ll>& out) {
        if (!x) return;
        postorder(x->left, out);
        postorder(x->right, out);
        out.push_back(x->key);
    }

    bool isBSTUtil(Node* node, ll minv, ll maxv) {
        if (!node) return true;
        if (node->key <= minv || node->key >= maxv) return false;
        return isBSTUtil(node->left, minv, node->key) && isBSTUtil(node->right, node->key, maxv);
    }
    bool isBST() {
        return isBSTUtil(root, numeric_limits<ll>::min(), numeric_limits<ll>::max());
    }

    Node* LCA(ll a, ll b) {
        Node* cur = root;
        while (cur) {
            if (a < cur->key && b < cur->key) cur = cur->left;
            else if (a > cur->key && b > cur->key) cur = cur->right;
            else return cur;
        }
        return nullptr;
    }

    Node* sortedArrayToBST(const vector<ll>& a) {
        return sortedArrayToBSTRec(a, 0, (int)a.size() - 1, nullptr);
    }
    Node* sortedArrayToBSTRec(const vector<ll>& a, int l, int r, Node* parent) {
        if (l > r) return nullptr;
        int mid = l + (r - l) / 2;
        Node* node = new Node(a[mid]);
        node->parent = parent;
        node->left = sortedArrayToBSTRec(a, l, mid - 1, node);
        node->right = sortedArrayToBSTRec(a, mid + 1, r, node);
        return node;
    }

    Node* kthSmallest(int k) {
        if (k <= 0) return nullptr;
        stack<Node*> st;
        Node* cur = root;
        int cnt = 0;
        while (cur || !st.empty()) {
            while (cur) { st.push(cur); cur = cur->left; }
            cur = st.top(); st.pop();
            ++cnt;
            if (cnt == k) return cur;
            cur = cur->right;
        }
        return nullptr;
    }

    Node* kthLargest(int k) {
        if (k <= 0) return nullptr;
        stack<Node*> st;
        Node* cur = root;
        int cnt = 0;
        while (cur || !st.empty()) {
            while (cur) { st.push(cur); cur = cur->right; }
            cur = st.top(); st.pop();
            ++cnt;
            if (cnt == k) return cur;
            cur = cur->left;
        }
        return nullptr;
    }

    // Utility wrappers for printing
    vector<ll> inorder() { vector<ll> v; inorder(root, v); return v; }
    vector<ll> preorder() { vector<ll> v; preorder(root, v); return v; }
    vector<ll> postorder() { vector<ll> v; postorder(root, v); return v; }

    // Build balanced BST from sorted array in-place: replaces current tree
    void buildFromSortedArray(const vector<ll>& a) {
        clear(root);
        root = sortedArrayToBSTRec(a, 0, (int)a.size()-1, nullptr);
    }
};

// Minimal example usage (can be removed in integration)
int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    BST tree;
    vector<ll> vals = {20, 10, 30, 5, 15, 25, 35};
    for (ll v : vals) tree.insert(v);

    auto in = tree.inorder();
    for (ll x : in) cout << x << ' ';
    cout << '\n';

    cout << "min: " << (tree.minimum()? tree.minimum()->key : -1) << ", max: " << (tree.maximum()? tree.maximum()->key : -1) << '\n';

    Node* s = tree.search(15);
    cout << "search 15: " << (s? "found" : "not found") << '\n';

    Node* suc = tree.successor(tree.search(15));
    cout << "successor of 15: " << (suc? to_string(suc->key) : string("none")) << '\n';

    Node* pred = tree.predecessor(tree.search(15));
    cout << "predecessor of 15: " << (pred? to_string(pred->key) : string("none")) << '\n';

    cout << "isBST: " << (tree.isBST() ? "yes" : "no") << '\n';

    Node* lca = tree.LCA(5, 15);
    cout << "LCA of 5 and 15: " << (lca? to_string(lca->key) : string("none")) << '\n';

    Node* ksmall = tree.kthSmallest(3);
    cout << "3rd smallest: " << (ksmall? to_string(ksmall->key) : string("none")) << '\n';

    Node* klarg = tree.kthLargest(2);
    cout << "2nd largest: " << (klarg? to_string(klarg->key) : string("none")) << '\n';

    // Build balanced BST from sorted array
    vector<ll> sorted = {1,2,3,4,5,6,7};
    tree.buildFromSortedArray(sorted);
    auto in2 = tree.inorder();
    for (ll x : in2) cout << x << ' ';
    cout << '\n';

    return 0;
}