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
};

class LinkedList {
private:
    Node* head;
    int noOfElements;
public:
    LinkedList(); //Constructor

    void Insert(int pos, int x);
    void remove(int pos);
    int get(int pos);
    int size();
    void display();
};

LinkedList::LinkedList() {
    head = nullptr;
    noOfElements = 0;
}

void LinkedList::Insert(int e, int pos) {
    if (pos < 0 || pos > noOfElements) {
        cout << "The position " << pos << " is Invalid\n";
        return;
    }
    Node* newNode = new Node();
    newNode->data = e;
    if (pos == 0) {
        newNode->next = head;
        head = newNode;
    } else {
        Node* temp = head;
        FOR(i, 1, pos - 1) {
            temp = temp->next;
        }
        newNode->next = temp->next;
        temp->next = newNode;
    }
    noOfElements++;
}
void LinkedList::remove(int pos) {
    if (pos < 0 || pos >= noOfElements) {
        cout << "The position " << pos << " is Invalid\n";
        return;
    }
    Node* temp = head;
    if (pos == 0) {
        head = head->next;
        delete temp;
    } else {
        FOR(i, 1, pos - 1) {
            temp = temp->next;
        }
        Node* nodeToDelete = temp->next;
        temp->next = nodeToDelete->next;
        delete nodeToDelete;
    }
    noOfElements--;
}
int LinkedList::get(int pos) {
    if (pos < 0 || pos >= noOfElements) {
        cout << "The position " << pos << " is Invalid\n";
        return -1; // or some error value
    }
    Node* temp = head;
    FOR(i, 0, pos - 1) {
        temp = temp->next;
    }
    return temp->data;
}
int LinkedList::size() {
    return noOfElements;
}
void LinkedList::display() {
    Node* temp = head;
    while (temp != nullptr) {
        cout << temp->data << " ";
        temp = temp->next;
    }
    cout << '\n';
}

signed main()
{
    ios_base::sync_with_stdio(0); cin.tie(0);
    //freopen(file".INP","r",stdin);
    //freopen(file".OUT","w",stdout);

    LinkedList list;
    list.Insert(10, 0); // Insert 10 at position 0
    list.Insert(20, 1); // Insert 20 at position 1
    list.Insert(15, 1); // Insert 15 at position 1
    list.display(); // Expected output: 10 15 20

    cout << "Element at position 1: " << list.get(1) << '\n'; // Expected output: 15
    cout << "Size of the list: " << list.size() << '\n'; // Expected output: 3

    list.remove(1); // Remove element at position 1
    list.display(); // Expected output: 10 20
    cout << "Size of the list after removal: " << list.size() << '\n'; // Expected output: 2

    return 0;
}
