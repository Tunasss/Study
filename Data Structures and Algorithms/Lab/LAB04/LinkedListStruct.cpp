//Implement Link List using Struct
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

    void Insert(int e, int pos);
    void Delete(int pos);
    void isEmpty();
    void Print();
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

void LinkedList::Delete(int pos) {
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

void LinkedList::isEmpty() {
    if (noOfElements == 0) {
        cout << "Linked List is Empty\n";
    } else {
        cout << "Linked List is Not Empty\n";
    }
}

void LinkedList::Print() {
    Node* temp = head;
    while (temp != nullptr) {
        cout << temp->data << " ";
        temp = temp->next;
    }
    cout << '\n';
}

int main() {
    LinkedList ll;
    ll.Insert(10, 0); 
    ll.Insert(20, 1); 
    ll.Insert(15, 1); 
    ll.Insert(5, 0);
    ll.Insert(25, 5);

    ll.isEmpty();

    ll.Print();

    ll.Delete(1);    
    ll.Print();      

    ll.Delete(0);    
    ll.Delete(3);
    ll.Print();    

    return 0;
}