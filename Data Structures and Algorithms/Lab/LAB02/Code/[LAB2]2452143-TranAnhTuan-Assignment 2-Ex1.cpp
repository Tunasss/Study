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

struct Node {
    int data; // Data part of the node
    Node* next; // Pointer to the next node
    Node(int val) : data(val), next(nullptr) {}  // Constructor initializes node
};

class LinkedList {
private:
    Node* head; // Pointer to the first node (head of list)
public:
    LinkedList() : head(nullptr) {}

    void insertFront(int val) {
        Node* newNode = new Node(val);  // Create new node with given value
        newNode->next = head; // Point new node to current head
        head = newNode; // Update head to new node
    }

    void insertBack(int val) {
        Node* newNode = new Node(val);  // Create new node
        if (!head) { // If list is empty
            head = newNode; // New node becomes head
            return;
        }
        Node* temp = head; // Temporary pointer to traverse list
        while (temp->next) { // Move until last node
            temp = temp->next;
        }
        temp->next = newNode; // Link last node to new node
    }
    
    bool search(int val) {
        Node* temp = head; // Start from the head
        while (temp) {
            if (temp->data == val) { // If found, return true
                return true;
            }
            temp = temp->next; // Move to next node
        }
        return false; // Not found
    }

    void deleteElement(int val) {
        if (!head) return; // Empty list → nothing to delete

        // If the head node itself holds the value
        if (head->data == val) {
            Node* temp = head; // Save current head
            head = head->next; // Move head to next node
            delete temp; // Delete old head
            return;
        }

        // Otherwise, find the node before the one to delete
        Node* current = head;
        Node* previous = nullptr;
        while (current && current->data != val) {
            previous = current;
            current = current->next;
        }

        // If found, remove it
        if (current) {
            previous->next = current->next;
            delete current;
        }
    }
    void printList() {
        Node* temp = head;
        while (temp) {
            cout << temp->data << " "; 
            temp = temp->next;
        }
        cout << endl;
    }
};

signed main()
{
    ios_base::sync_with_stdio(0); cin.tie(0);
    //freopen(file".INP","r",stdin);
    //freopen(file".OUT","w",stdout);

    LinkedList list;
    
    list.insertFront(4);
    list.insertFront(6);
    list.insertBack(8);
    list.insertBack(10);

    cout << "Find 5: " << (list.search(5) ? "True" : "False") << '\n'; //False
    cout << "Find 6: " << (list.search(6) ? "True" : "False") << '\n'; //True

    list.deleteElement(6);

    cout << "Find 6 after deletion: " << (list.search(6) ? "True" : "False") << '\n'; //False

    cout << "Current List: ";
    list.printList();

    return 0;
}