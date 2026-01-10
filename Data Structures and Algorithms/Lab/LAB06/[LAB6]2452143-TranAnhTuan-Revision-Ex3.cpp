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


// Custom deque implemented as a doubly-linked list (no std::deque used)
    struct Node {
        long long val;
        Node *prev, *next;
        Node(long long v): val(v), prev(nullptr), next(nullptr) {}
    };

    struct Deque {
        Node *head, *tail;
        Deque(): head(nullptr), tail(nullptr) {}
        ~Deque() {
            while (head) {
                Node *t = head;
                head = head->next;
                delete t;
            }
        }
        bool empty() const { return head == nullptr; }
        void push_front(long long x) {
            Node *n = new Node(x);
            if (!head) head = tail = n;
            else {
                n->next = head;
                head->prev = n;
                head = n;
            }
        }
        void push_back(long long x) {
            Node *n = new Node(x);
            if (!tail) head = tail = n;
            else {
                tail->next = n;
                n->prev = tail;
                tail = n;
            }
        }
        void pop_front() {
            if (!head) return;
            Node *t = head;
            head = head->next;
            if (head) head->prev = nullptr;
            else tail = nullptr;
            delete t;
        }
        void pop_back() {
            if (!tail) return;
            Node *t = tail;
            tail = tail->prev;
            if (tail) tail->next = nullptr;
            else head = nullptr;
            delete t;
        }
        long long front() const { return head ? head->val : 0; }
        long long back() const { return tail ? tail->val : 0; }
    } dq;


int main() {
    // Menu-driven numeric commands
    // 1: insertFront x
    // 2: insertBack x
    // 3: eraseFront
    // 4: eraseBack
    // 5: front
    // 6: back
    // 7: isEmpty
    // 8: exit

    while (true) {
        cout << "--- Deque Menu ---\n";
        cout << "1. insertFront x\n";
        cout << "2. insertBack x\n";
        cout << "3. eraseFront\n";
        cout << "4. eraseBack\n";
        cout << "5. front\n";
        cout << "6. back\n";
        cout << "7. isEmpty\n";
        cout << "8. exit\n";
        cout << "Choose an option: ";

        int opt;
        cin >> opt;

        if (opt == 1) {
            long long x; if (!(cin >> x)) break;
            dq.push_front(x);
        } else if (opt == 2) {
            long long x; if (!(cin >> x)) break;
            dq.push_back(x);
        } else if (opt == 3) {
            dq.pop_front();
        } else if (opt == 4) {
            dq.pop_back();
        } else if (opt == 5) {
            if (dq.empty()) cout << "EMPTY" << '\n';
            else cout << dq.front() << '\n';
        } else if (opt == 6) {
            if (dq.empty()) cout << "EMPTY" << '\n';
            else cout << dq.back() << '\n';
        } else if (opt == 7) {
            cout << (dq.empty() ? "YES" : "NO") << '\n';
        } else if (opt == 8) {
            break;
        } else {
            cout << "Invalid option" << '\n';
        }
        cout << '\n';
    }

    return 0;
}
