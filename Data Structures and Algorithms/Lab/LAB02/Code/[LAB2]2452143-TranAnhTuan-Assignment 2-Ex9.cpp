#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
typedef unsigned long long ull;
typedef string str;
typedef pair<int, int> ii;
#define file "TEST"
#define st first
#define nd second
#define pb push_back
#define lb lower_bound
#define ub upper_bound
#define vll vector<ll>
#define vi vector<int>
#define all(v) (v).begin(), (v).end()
#define FOR(i, x, y) for (ll i = x; i <= y; ++i)
#define FOS(i, x, y) for (ll i = x; i >= y; --i)
#define EACH(i, x) for (auto &(i) : (x))
#define el cout << '\n';
const ll MOD = 1e9 + 7;
#define dbg(...) cerr << "[" << #__VA_ARGS__ ": " << (__VA_ARGS__) << "]  "
#define dbge(...) cerr << "[" << #__VA_ARGS__ ": " << (__VA_ARGS__) << "]" << endl;

/*
mt19937_64 rd(chrono::steady_clock::now().time_since_epoch().count());
ll rand(ll l, ll r) { return uniform_int_distribution<ll>(l, r)(rd); }
*/

//#define int long long

struct Node
{
    int data;
    Node *left;
    Node *right;
    Node(int val) : data(val), left(nullptr), right(nullptr) {}
};
struct BinaryTree
{
    Node *root;
    BinaryTree() : root(nullptr) {}

    Node *CreateNode(int val)
    {
        Node *newNode = new Node(val);
        return newNode;
    }

    void inorder(Node *root)
    {
        if (root)
        {
            inorder(root->left);
            cout << root->data << " ";
            inorder(root->right);
        }
    }

    void InsertNode(int val)
    {
        if (!root)
        {
            root = CreateNode(val);
            return;
        }
        queue<Node *> q;
        q.push(root);
        while (!q.empty())
        {
            Node *temp = q.front();
            q.pop();
            if (!temp->left)
            {
                temp->left = CreateNode(val);
                break;
            }
            else
            {
                q.push(temp->left);
            }
            if (!temp->right)
            {
                temp->right = CreateNode(val);
                break;
            }
            else
            {
                q.push(temp->right);
            }
        }
    }   
    bool SearchNode(Node* root, int val)
    {
        if (!root)
            return false;
        if (root->data == val)
            return true;
        return SearchNode(root->left, val) || SearchNode(root->right, val);
    }
};

int main()
{
    BinaryTree myTree;

    vector<int> values = {5, 3, 7, 2, 4, 6, 8};
    cout << "Input: ";
    for (int val : values){
        cout << val << " ";
        myTree.InsertNode(val);
    }
    el;

    cout << "Output:\n";
    cout << "Inorder (sorted): ";
    myTree.inorder(myTree.root);
    el;

    cout << "Enter value to search: ";
    int searchVal;
    cin >> searchVal;
    if (myTree.SearchNode(myTree.root, searchVal))
        cout << "Result: Found node " << searchVal << " in the tree.";
    else
        cout << "Result: Node " << searchVal << " not found in the tree.";

    return 0;
}