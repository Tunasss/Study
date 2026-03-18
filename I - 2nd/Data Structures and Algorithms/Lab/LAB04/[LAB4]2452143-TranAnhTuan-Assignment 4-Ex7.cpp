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

class DoublyCircularLinkedList {
private:
    Node* head;

public:
    DoublyCircularLinkedList() : head(nullptr) {}

    // Destructor
    ~DoublyCircularLinkedList() {
        if (head == nullptr) return;

        Node* current = head;
        // Break the circle to safely delete standardly
        // or just loop until we hit head again
        do {
            Node* nextNode = current->next;
            delete current;
            current = nextNode;
        } while (current != head);
        
        head = nullptr;
    }

    // 1. Insert at Head (Push Front)
    void insertAtHead(int val) {
        Node* newNode = new Node(val);

        if (head == nullptr) {
            head = newNode;
            head->next = head; // Points to itself
            head->prev = head; // Points to itself
        } else {
            Node* tail = head->prev; // Access tail in O(1)

            // Link new node to head and tail
            newNode->next = head;
            newNode->prev = tail;

            // Update head and tail pointers
            head->prev = newNode;
            tail->next = newNode;

            // Move head to the new node
            head = newNode;
        }
    }

    // 2. Insert at Tail (Push Back)
    void insertAtTail(int val) {
        Node* newNode = new Node(val);

        if (head == nullptr) {
            head = newNode;
            head->next = head;
            head->prev = head;
        } else {
            Node* tail = head->prev; // Access tail in O(1)

            // Link new node
            newNode->next = head;
            newNode->prev = tail;

            // Update existing pointers
            tail->next = newNode;
            head->prev = newNode;
            
            // Note: We do NOT move 'head' here.
        }
    }

    // 3. Delete Head (Pop Front)
    void deleteHead() {
        if (head == nullptr) return;

        // Case: Only one node
        if (head->next == head) {
            delete head;
            head = nullptr;
            return;
        }

        Node* tail = head->prev;
        Node* temp = head;

        // Update links to skip the current head
        tail->next = head->next;
        head->next->prev = tail;

        // Move head forward
        head = head->next;

        delete temp;
    }

    // 4. Delete Tail (Pop Back)
    void deleteTail() {
        if (head == nullptr) return;

        // Case: Only one node
        if (head->next == head) {
            delete head;
            head = nullptr;
            return;
        }

        Node* tail = head->prev;
        Node* newTail = tail->prev; // The node before tail

        // Update links to skip the current tail
        newTail->next = head;
        head->prev = newTail;

        delete tail;
    }

    // 5. Delete specific value
    void deleteNode(int val) {
        if (head == nullptr) return;

        Node* current = head;

        do {
            if (current->data == val) {
                // Case: Single node list
                if (current->next == current) {
                    delete current;
                    head = nullptr;
                    return;
                }

                // Case: Deleting the head
                if (current == head) {
                    deleteHead(); // Reuse logic
                    return;
                }

                // Case: Deleting middle or tail
                Node* before = current->prev;
                Node* after = current->next;

                before->next = after;
                after->prev = before;

                delete current;
                return;
            }
            current = current->next;
        } while (current != head);

        cout << "Value " << val << " not found.\n";
    }

    // 6. Display Forward
    void displayForward() {
        if (head == nullptr) {
            cout << "List is empty.\n";
            return;
        }
        Node* temp = head;
        cout << "Forward:  ";
        do {
            cout << temp->data << " <-> ";
            temp = temp->next;
        } while (temp != head);
        cout << "(Head)" << endl;
    }

    // 7. Display Backward
    void displayBackward() {
        if (head == nullptr) return;
        
        Node* temp = head->prev; // Start at tail
        cout << "Backward: ";
        do {
            cout << temp->data << " <-> ";
            temp = temp->prev;
        } while (temp != head->prev); // Stop when we get back to tail
        cout << "(Tail)" << endl;
    }
};

// --- Driver Code ---
int main() {
    DoublyCircularLinkedList dcll;

    // Build list: 10 <-> 20 <-> 30
    dcll.insertAtTail(20);
    dcll.insertAtHead(10);
    dcll.insertAtTail(30);

    cout << "--- Initial List ---" << endl;
    dcll.displayForward();  // Expected: 10 <-> 20 <-> 30
    dcll.displayBackward(); // Expected: 30 <-> 20 <-> 10

    cout << "\n--- Deleting Head (10) ---" << endl;
    dcll.deleteHead();
    dcll.displayForward();  // Expected: 20 <-> 30

    cout << "\n--- Deleting Tail (30) ---" << endl;
    dcll.deleteTail();
    dcll.displayForward();  // Expected: 20

    cout << "\n--- Deleting Remaining (20) ---" << endl;
    dcll.deleteNode(20);
    dcll.displayForward();  // Expected: Empty

    return 0;
}