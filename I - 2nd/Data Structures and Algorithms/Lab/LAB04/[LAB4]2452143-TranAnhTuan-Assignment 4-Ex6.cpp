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
    
    Node(int val) : data(val), next(nullptr) {}
};

class CircularLinkedList {
private:
    Node* head;

public:
    CircularLinkedList() : head(nullptr) {}

    // Destructor to properly clean up memory
    ~CircularLinkedList() {
        if (head == nullptr) return;

        Node* current = head;
        Node* nextNode = nullptr;

        // We need to break the circle to delete safely, 
        // or simpler: loop until we get back to head
        do {
            nextNode = current->next;
            delete current;
            current = nextNode;
        } while (current != head);
        
        head = nullptr;
    }

    // 1. Insert at the Beginning
    void insertAtHead(int val) {
        Node* newNode = new Node(val);

        if (head == nullptr) {
            head = newNode;
            newNode->next = head; // Points to itself
        } else {
            Node* temp = head;
            // Find the last node (tail)
            while (temp->next != head) {
                temp = temp->next;
            }
            // Point last node to new node
            temp->next = newNode;
            // Point new node to current head
            newNode->next = head;
            // Update head pointer
            head = newNode;
        }
    }

    // 2. Insert at the End
    void insertAtTail(int val) {
        Node* newNode = new Node(val);

        if (head == nullptr) {
            head = newNode;
            newNode->next = head; // Points to itself
        } else {
            Node* temp = head;
            // Find the last node
            while (temp->next != head) {
                temp = temp->next;
            }
            // Point last node to new node
            temp->next = newNode;
            // Point new node back to head to complete circle
            newNode->next = head;
        }
    }

    // 3. Delete a specific value
    void deleteNode(int val) {
        if (head == nullptr) return;

        // Case 1: The list contains only one node
        if (head->next == head) {
            if (head->data == val) {
                delete head;
                head = nullptr;
            } else {
                cout << "Value not found." << endl;
            }
            return;
        }

        // Case 2: The node to delete is the Head
        if (head->data == val) {
            Node* tail = head;
            // We must find the tail to update its next pointer
            while (tail->next != head) {
                tail = tail->next;
            }
            
            Node* temp = head;
            tail->next = head->next; // Tail points to new head
            head = head->next;       // Move head forward
            delete temp;
            return;
        }

        // Case 3: The node is elsewhere in the list
        Node* current = head;
        Node* prev = nullptr;

        // Traverse until we find the node OR we circle back to head
        do {
            prev = current;
            current = current->next;
            
            if (current->data == val) {
                prev->next = current->next;
                delete current;
                return;
            }
        } while (current != head); // Stop if we are back at start

        cout << "Value " << val << " not found." << endl;
    }

    // 4. Display the list
    void display() {
        if (head == nullptr) {
            cout << "List is empty." << endl;
            return;
        }

        Node* temp = head;
        
        // Use a do-while loop to ensure the body runs at least once
        // (since temp starts at head, a while loop would fail immediately if checking temp != head)
        do {
            cout << temp->data << " -> ";
            temp = temp->next;
        } while (temp != head);
        
        cout << "(Head)" << endl;
    }
};

// --- Test Driver ---
int main() {
    CircularLinkedList cll;

    cll.insertAtTail(10);
    cll.insertAtTail(20);
    cll.insertAtTail(30);
    cll.insertAtHead(5); // List: 5 -> 10 -> 20 -> 30 -> (Head)

    cout << "Initial Circular List: ";
    cll.display();

    cout << "Deleting 5 (Head)..." << endl;
    cll.deleteNode(5);
    cll.display();

    cout << "Deleting 20 (Middle)..." << endl;
    cll.deleteNode(20);
    cll.display();

    cout << "Deleting 30 (Tail)..." << endl;
    cll.deleteNode(30);
    cll.display();

    return 0;
}