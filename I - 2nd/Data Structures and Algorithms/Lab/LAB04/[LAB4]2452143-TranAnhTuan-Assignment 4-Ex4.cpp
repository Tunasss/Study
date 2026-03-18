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
    int data;
    Node* next;
    Node* prev;

    Node(int val) : data(val), next(nullptr), prev(nullptr) {}
};

//Implement doubly linked list with functions as in singly linked list.
struct Node {
    int data;
    Node* next;
    Node* prev;

    Node(int val) : data(val), next(nullptr), prev(nullptr) {}
};

class DoublyLinkedList {
private:
    Node* head;
    Node* tail;

public:
    // Constructor
    DoublyLinkedList() : head(nullptr), tail(nullptr) {}

    // Destructor: Clean up memory
    ~DoublyLinkedList() {
        Node* current = head;
        while (current != nullptr) {
            Node* nextNode = current->next;
            delete current;
            current = nextNode;
        }
    }

    // Append to the end of the list
    void push_back(int val) {
        Node* newNode = new Node(val);
        if (tail == nullptr) {
            head = tail = newNode;
        } else {
            tail->next = newNode;
            newNode->prev = tail;
            tail = newNode;
        }
    }

    // Prepend to the start of the list
    void push_front(int val) {
        Node* newNode = new Node(val);
        if (head == nullptr) {
            head = tail = newNode;
        } else {
            newNode->next = head;
            head->prev = newNode;
            head = newNode;
        }
    }

    // --- THE REVERSE FUNCTION ---
    void reverse() {
        // Edge case: If list is empty or has only one node, do nothing
        if (head == nullptr || head->next == nullptr) {
            return;
        }

        Node* current = head;
        Node* temp = nullptr;

        // 1. Update the tail pointer to be the current head
        // (Since we are reversing, the old head will become the new tail)
        tail = head;

        // 2. Swap next and prev for every node in the list
        while (current != nullptr) {
            temp = current->prev;           // Save the previous pointer
            current->prev = current->next;  // Swap: prev becomes next
            current->next = temp;           // Swap: next becomes prev

            // Move to the next node
            // CAUTION: Since we swapped pointers, the "physical next" node
            // is now stored in current->prev
            current = current->prev;
        }

        // 3. Update the head pointer
        // After the loop, 'temp' points to the node that used to be 'next'
        // of the new head. So the new head is temp->prev.
        if (temp != nullptr) {
            head = temp->prev;
        }
    }

    // Display list from Head to Tail
    void printForward() {
        Node* temp = head;
        std::cout << "Forward:  nullptr <-> ";
        while (temp != nullptr) {
            std::cout << temp->data << " <-> ";
            temp = temp->next;
        }
        std::cout << "nullptr" << std::endl;
    }

    // Display list from Tail to Head (Verifies back links are correct)
    void printBackward() {
        Node* temp = tail;
        std::cout << "Backward: nullptr <-> ";
        while (temp != nullptr) {
            std::cout << temp->data << " <-> ";
            temp = temp->prev;
        }
        std::cout << "nullptr" << std::endl;
    }
};

int main() {
    ios_base::sync_with_stdio(0); cin.tie(0);
    //freopen(file".INP","r",stdin);
    //freopen(file".OUT","w",stdout);

    DoublyLinkedList dll;

    // 1. Build the list
    dll.push_back(10);
    dll.push_back(20);
    dll.push_back(30);
    dll.push_back(40);

    std::cout << "--- Original List ---" << std::endl;
    dll.printForward();
    dll.printBackward();

    // 2. Reverse the list
    dll.reverse();

    std::cout << "\n--- Reversed List ---" << std::endl;
    dll.printForward();   // Should be 40 -> 30 -> 20 -> 10
    dll.printBackward();  // Should be 10 -> 20 -> 30 -> 40

    return 0;
}