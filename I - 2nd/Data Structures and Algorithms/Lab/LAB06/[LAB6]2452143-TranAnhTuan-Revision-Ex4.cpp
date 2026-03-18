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


enum Color { RED, BLACK };

struct Node {
	int key;
	Color color;
	Node *left, *right, *parent;
	Node(int k = 0): key(k), color(BLACK), left(nullptr), right(nullptr), parent(nullptr) {}
};

struct RBTree {
	Node *root;
	Node *NIL;

	RBTree() {
		NIL = new Node();
		NIL->color = BLACK;
		NIL->left = NIL->right = NIL->parent = NIL;
		root = NIL;
	}

	Node* searchNode(int key) {
		Node *cur = root;
		while (cur != NIL) {
			if (key == cur->key) return cur;
			cur = (key < cur->key) ? cur->left : cur->right;
		}
		return NIL;
	}

	bool find(int key) { return searchNode(key) != NIL; }

	void leftRotate(Node *x) {
		Node *y = x->right;
		x->right = y->left;
		if (y->left != NIL) y->left->parent = x;
		y->parent = x->parent;
		if (x->parent == NIL) root = y;
		else if (x == x->parent->left) x->parent->left = y;
		else x->parent->right = y;
		y->left = x;
		x->parent = y;
	}

	void rightRotate(Node *y) {
		Node *x = y->left;
		y->left = x->right;
		if (x->right != NIL) x->right->parent = y;
		x->parent = y->parent;
		if (y->parent == NIL) root = x;
		else if (y == y->parent->right) y->parent->right = x;
		else y->parent->left = x;
		x->right = y;
		y->parent = x;
	}

	void insert(int key) {
		Node *z = new Node(key);
		z->color = RED;
		z->left = z->right = z->parent = NIL;

		Node *y = NIL;
		Node *x = root;
		while (x != NIL) {
			y = x;
			if (key == x->key) { delete z; return; } // ignore duplicates
			x = (key < x->key) ? x->left : x->right;
		}
		z->parent = y;
		if (y == NIL) root = z;
		else if (key < y->key) y->left = z;
		else y->right = z;

		insertFixup(z);
	}

	void insertFixup(Node *z) {
		while (z->parent->color == RED) {
			if (z->parent == z->parent->parent->left) {
				Node *y = z->parent->parent->right;
				if (y->color == RED) {
					z->parent->color = BLACK;
					y->color = BLACK;
					z->parent->parent->color = RED;
					z = z->parent->parent;
				} else {
					if (z == z->parent->right) {
						z = z->parent;
						leftRotate(z);
					}
					z->parent->color = BLACK;
					z->parent->parent->color = RED;
					rightRotate(z->parent->parent);
				}
			} else {
				Node *y = z->parent->parent->left;
				if (y->color == RED) {
					z->parent->color = BLACK;
					y->color = BLACK;
					z->parent->parent->color = RED;
					z = z->parent->parent;
				} else {
					if (z == z->parent->left) {
						z = z->parent;
						rightRotate(z);
					}
					z->parent->color = BLACK;
					z->parent->parent->color = RED;
					leftRotate(z->parent->parent);
				}
			}
		}
		root->color = BLACK;
	}

	void transplant(Node *u, Node *v) {
		if (u->parent == NIL) root = v;
		else if (u == u->parent->left) u->parent->left = v;
		else u->parent->right = v;
		v->parent = u->parent;
	}

	Node* minimum(Node *x) {
		while (x->left != NIL) x = x->left;
		return x;
	}

	void remove(int key) {
		Node *z = searchNode(key);
		if (z == NIL) return;
		Node *y = z;
		Color yOriginalColor = y->color;
		Node *x;
		if (z->left == NIL) {
			x = z->right;
			transplant(z, z->right);
		} else if (z->right == NIL) {
			x = z->left;
			transplant(z, z->left);
		} else {
			y = minimum(z->right);
			yOriginalColor = y->color;
			x = y->right;
			if (y->parent == z) {
				x->parent = y;
			} else {
				transplant(y, y->right);
				y->right = z->right;
				y->right->parent = y;
			}
			transplant(z, y);
			y->left = z->left;
			y->left->parent = y;
			y->color = z->color;
		}
		delete z;
		if (yOriginalColor == BLACK) deleteFixup(x);
	}

	void deleteFixup(Node *x) {
		while (x != root && x->color == BLACK) {
			if (x == x->parent->left) {
				Node *w = x->parent->right;
				if (w->color == RED) {
					w->color = BLACK;
					x->parent->color = RED;
					leftRotate(x->parent);
					w = x->parent->right;
				}
				if (w->left->color == BLACK && w->right->color == BLACK) {
					w->color = RED;
					x = x->parent;
				} else {
					if (w->right->color == BLACK) {
						w->left->color = BLACK;
						w->color = RED;
						rightRotate(w);
						w = x->parent->right;
					}
					w->color = x->parent->color;
					x->parent->color = BLACK;
					w->right->color = BLACK;
					leftRotate(x->parent);
					x = root;
				}
			} else {
				Node *w = x->parent->left;
				if (w->color == RED) {
					w->color = BLACK;
					x->parent->color = RED;
					rightRotate(x->parent);
					w = x->parent->left;
				}
				if (w->right->color == BLACK && w->left->color == BLACK) {
					w->color = RED;
					x = x->parent;
				} else {
					if (w->left->color == BLACK) {
						w->right->color = BLACK;
						w->color = RED;
						leftRotate(w);
						w = x->parent->left;
					}
					w->color = x->parent->color;
					x->parent->color = BLACK;
					w->left->color = BLACK;
					rightRotate(x->parent);
					x = root;
				}
			}
		}
		x->color = BLACK;
	}

	void inorderPrint(Node *node, vector<int> &out) {
		if (node == NIL) return;
		inorderPrint(node->left, out);
		out.push_back(node->key);
		inorderPrint(node->right, out);
	}

	vector<int> inorder() {
		vector<int> out;
		inorderPrint(root, out);
		return out;
	}

	string colorOf(int key) {
		Node *n = searchNode(key);
		if (n == NIL) return string("Not found");
		return (n->color == RED) ? string("RED") : string("BLACK");
	}
};

int main() {
	ios::sync_with_stdio(false);
	cin.tie(nullptr);

	RBTree tree;
	string cmd;
	while (cin >> cmd) {
		if (cmd == "insert") {
			int x; if (!(cin >> x)) break;
			tree.insert(x);
		} else if (cmd == "delete") {
			int x; if (!(cin >> x)) break;
			tree.remove(x);
		} else if (cmd == "find") {
			int x; if (!(cin >> x)) break;
			cout << (tree.find(x) ? "YES" : "NO") << '\n';
		} else if (cmd == "printInorder") {
			vector<int> v = tree.inorder();
			for (size_t i = 0; i < v.size(); ++i) {
				if (i) cout << ' ';
				cout << v[i];
			}
			cout << '\n';
		} else if (cmd == "printColor") {
			int x; if (!(cin >> x)) break;
			string res = tree.colorOf(x);
			cout << res << '\n';
		} else {
			string rest;
			getline(cin, rest);
		}
	}

	return 0;
}