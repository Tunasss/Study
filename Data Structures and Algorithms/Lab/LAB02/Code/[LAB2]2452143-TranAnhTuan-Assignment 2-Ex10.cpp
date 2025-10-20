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

    void DeleteTree(Node *&root)
    {
        if (root == nullptr)
            return;
        DeleteTree(root->left);
        DeleteTree(root->right);
        delete root;
        root = nullptr;
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
    void preorder(Node *root)
    {
        if (root)
        {
            cout << root->data << " ";
            preorder(root->left);
            preorder(root->right);
        }
    }
    void postorder(Node *root)
    {
        if (root)
        {
            postorder(root->left);
            postorder(root->right);
            cout << root->data << " ";
        }
    }

    int height(Node *root)
    {
        if (!root)
            return 0;
        int leftHeight = height(root->left);
        int rightHeight = height(root->right);
        return 1 + max(leftHeight, rightHeight);
    }

    int findMax(Node *root)
    {
        if (!root)
            return INT_MIN;
        int leftMax = findMax(root->left);
        int rightMax = findMax(root->right);
        return max(root->data, max(leftMax, rightMax));
    }
};

int main()
{
    BinaryTree myTree;

    //Create menu options
    int choice;
    do {
        cout << "Binary Tree Operations Menu:\n";
        cout << "1. Insert Node\n2. Inorder Traversal\n3. Preorder Traversal\n4. Postorder Traversal\n5. Delete Tree\n6. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice) {
            case 1: { 
                int val;
                cout << "Enter value to insert: ";
                cin >> val;
                if (!myTree.root) {
                    myTree.root = myTree.CreateNode(val);
                } else {
                    //Simple insertion for demonstration (not a BST)
                    queue<Node*> q;
                    q.push(myTree.root);
                    while (!q.empty()) {
                        Node* temp = q.front();
                        q.pop();
                        if (!temp->left) {
                            temp->left = myTree.CreateNode(val);
                            break;
                        } else {
                            q.push(temp->left);
                        }
                        if (!temp->right) {
                            temp->right = myTree.CreateNode(val);
                            break;
                        } else {
                            q.push(temp->right);
                        }
                    }
                }
                cout << "Node inserted.\n";
                break;
            }
            case 2:
                cout << "Inorder Traversal: ";
                myTree.inorder(myTree.root);
                cout << endl;
                break;
            case 3:
                cout << "Preorder Traversal: ";
                myTree.preorder(myTree.root);
                cout << endl;
                break;
            case 4:
                cout << "Postorder Traversal: ";
                myTree.postorder(myTree.root);
                cout << endl;
                break;
            case 5: 
                myTree.DeleteTree(myTree.root);
                cout << "Tree deleted.\n";
                break;
            case 6:
                cout << "Exiting...\n";
                break;
            default:
                cout << "Invalid choice. Please try again.\n";
        }
    } while (choice != 6);
    return 0;
}