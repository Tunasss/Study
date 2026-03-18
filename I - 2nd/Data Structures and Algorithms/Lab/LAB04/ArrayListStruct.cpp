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

class ArrayList {
private:    
#define MAX_SIZE 100
    int elements[MAX_SIZE];
    int noOfElements = 0;

public:
    ArrayList(); //Constructor

    void Insert(int e, int pos);
    void Delete(int pos);
    int Find(int e);
    bool isEmpty();
    int First();
    int Last();
    int Kth(int pos);
    int Length();
};

ArrayList::ArrayList() {
    noOfElements = 0;
}

void ArrayList::Insert(int e, int pos) {
    if (noOfElements >= MAX_SIZE || pos < 0 || pos > noOfElements) {
        cout << "Insertion Error: Invalid position or list is full." << endl;
        return;
    }
    for (int i = noOfElements; i > pos; --i) {
        elements[i] = elements[i - 1];
    }
    elements[pos] = e;
    noOfElements++;
}
void ArrayList::Delete(int pos) {
    if (pos < 0 || pos >= noOfElements) {
        cout << "Deletion Error: Invalid position." << endl;
        return;
    }
    for (int i = pos; i < noOfElements - 1; ++i) {
        elements[i] = elements[i + 1];
    }
    noOfElements--;
}
int ArrayList::Find(int e) {
    for (int i = 0; i < noOfElements; ++i) {
        if (elements[i] == e) {
            return i;
        }
    }
    return -1;
}
bool ArrayList::isEmpty() {
    return noOfElements == 0;
}

int ArrayList::First() {
    if (isEmpty()) {
        cout << "List is empty." << endl;
        return -1;
    }
    return elements[0];
}

int ArrayList::Last() {
    if (isEmpty()) {
        cout << "List is empty." << endl;
        return -1;
    }
    return elements[noOfElements - 1];
}
int ArrayList::Kth(int pos) {
    if (pos < 0 || pos >= noOfElements) {
        cout << "Error: Invalid position." << endl;
        return -1;
    }
    return elements[pos];
}
int ArrayList::Length() {
    return noOfElements;
}

int main(){
    ArrayList list;

    list.Insert(10, 0);
    list.Insert(20, 1);
    list.Insert(15, 1);

    cout << "Is List Empty? " << (list.isEmpty() ? "Yes" : "No") << endl;
    cout << "First Element: " << list.First() << endl;
    cout << "Last Element: " << list.Last() << endl;
    cout << "Element at position 1: " << list.Kth(1) << endl;
    cout << "Length of List: " << list.Length() << endl;

    int pos = list.Find(15);
    if (pos != -1) {
        cout << "Element 15 found at position: " << pos << endl;
    } else {
        cout << "Element 15 not found." << endl;
    }

    list.Delete(1);
    cout << "Length of List after deletion: " << list.Length() << endl;

    return 0;
}