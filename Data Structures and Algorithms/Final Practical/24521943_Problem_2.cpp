// 24521943 - Tran Anh Tuan

#include <bits/stdc++.h>
using namespace std;
typedef long long ll;

const ll N = 2e5 + 5;

int root[N];

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

TreeNode* buildTree(const vector<string>& nodes) {
    if (nodes.empty() || nodes[0] == "N") return NULL;

    TreeNode* root = new TreeNode(stoi(nodes[0]));
    queue<TreeNode*> q;
    q.push(root);

    int i = 1;
    while (!q.empty() && i < nodes.size()) {
        TreeNode* curr = q.front();
        q.pop();

        if (i < nodes.size()) {
            if (nodes[i] != "N") {
                curr->left = new TreeNode(stoi(nodes[i]));
                q.push(curr->left);
            }
            i++;
        }

        if (i < nodes.size()) {
            if (nodes[i] != "N") {
                curr->right = new TreeNode(stoi(nodes[i]));
                q.push(curr->right);
            }
            i++;
        }
    }
    return root;
}

void inorderTraversal(TreeNode* root, vector<int>& values) {
    if (root == NULL) return;
    inorderTraversal(root->left, values);
    values.push_back(root->val);
    inorderTraversal(root->right, values);
}


int findMedian(TreeNode* root) {
    vector<int> sortedValues;
    inorderTraversal(root, sortedValues);

    int n = sortedValues.size();
    if (n == 0) return 0;

    if (n % 2 == 0) {
        return sortedValues[(n / 2) - 1];
    } else {
        return sortedValues[((n + 1) / 2) - 1];
    }
}


signed main()
{
    ios_base::sync_with_stdio(0); 
    cin.tie(0);

    vector<string> input = {"20", "8", "22", "4", "12", "N", "N", "N", "N", "10", "14"};

    TreeNode* root = buildTree(input);

    int result = findMedian(root);

    cout << result << endl;

    return 0;
}
