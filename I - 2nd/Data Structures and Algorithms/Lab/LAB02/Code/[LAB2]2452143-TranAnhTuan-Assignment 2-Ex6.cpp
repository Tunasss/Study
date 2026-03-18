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

enum Color { RED, BLACK };
struct Node {
    int data;
    Color color;
    Node *left, *right, *parent;

    Node(int val) : data(val), color(RED), left(nullptr), right(nullptr), parent(nullptr) {}
};
class RBTree {
private:
    Node* root;

    void rotateLeft(Node* &pt) {
        Node* pt_y = pt->right;
        pt->right = pt_y->left;

        if (pt->right != nullptr)
            pt->right->parent = pt;

        pt_y->parent = pt->parent;

        if (pt->parent == nullptr)
            root = pt_y;
        else if (pt == pt->parent->left)
            pt->parent->left = pt_y;
        else
            pt->parent->right = pt_y;

        pt_y->left = pt;
        pt->parent = pt_y;
    }
    void rotateRight(Node* &pt) {
        Node* pt_y = pt->left;
        pt->left = pt_y->right;

        if (pt->left != nullptr)
            pt->left->parent = pt;

        pt_y->parent = pt->parent;

        if (pt->parent == nullptr)
            root = pt_y;
        else if (pt == pt->parent->left)
            pt->parent->left = pt_y;
        else
            pt->parent->right = pt_y;

        pt_y->right = pt;
        pt->parent = pt_y;
    }
    void fixViolation(Node* &pt) {
        Node* pt_parent = nullptr;
        Node* pt_grandparent = nullptr;

        while ((pt != root) && (pt->color == RED) && (pt->parent->color == RED)) {
            pt_parent = pt->parent;
            pt_grandparent = pt->parent->parent;

            if (pt_parent == pt_grandparent->left) {
                Node* pt_uncle = pt_grandparent->right;

                if (pt_uncle != nullptr && pt_uncle->color == RED) {
                    pt_grandparent->color = RED;
                    pt_parent->color = BLACK;
                    pt_uncle->color = BLACK;
                    pt = pt_grandparent;
                } else {
                    if (pt == pt_parent->right) {
                        rotateLeft(pt_parent);
                        pt = pt_parent;
                        pt_parent = pt->parent;
                    }
                    rotateRight(pt_grandparent);
                    swap(pt_parent->color, pt_grandparent->color);
                    pt = pt_parent;
                }
            } else {
                Node* pt_uncle = pt_grandparent->left;

                if ((pt_uncle != nullptr) && (pt_uncle->color == RED)) {
                    pt_grandparent->color = RED;
                    pt_parent->color = BLACK;
                    pt_uncle->color = BLACK;
                    pt = pt_grandparent;
                } else {
                    if (pt == pt_parent->left) {
                        rotateRight(pt_parent);
                        pt = pt_parent;
                        pt_parent = pt->parent;
                    }
                    rotateLeft(pt_grandparent);
                    swap(pt_parent->color, pt_grandparent->color);
                    pt = pt_parent;
                }
            }
        }
        root->color = BLACK;
    }
public:
    RBTree() : root(nullptr) {}
    void insert(const int &data) {
        Node* pt = new Node(data);
        root = BSTInsert(root, pt);
        fixViolation(pt);
    }
    Node* BSTInsert(Node* root, Node* pt) {
        if (root == nullptr)
            return pt;

        if (pt->data < root->data) {
            root->left = BSTInsert(root->left, pt);
            root->left->parent = root;
        } else if (pt->data > root->data) {
            root->right = BSTInsert(root->right, pt);
            root->right->parent = root;
        }

        return root;
    }
    void inorder(Node* node) {
        if (node == nullptr)
            return;

        inorder(node->left);
        cout << node->data << "(" << (node->color == RED ? "R" : "B") << ") ";
        inorder(node->right);
    }
    void inorder() {
        inorder(root);
    }
};
int main() {
    RBTree myRBTree;
    int n = 6;
    int values[n] = {10, 5, 15, 2, 7, 13};

    FOR(i, 0, n - 1) {
        myRBTree.insert(values[i]);
    }

    cout << "Inorder Traversal of Created Tree\n";
    myRBTree.inorder();
    cout << '\n';   


    return 0;
}
