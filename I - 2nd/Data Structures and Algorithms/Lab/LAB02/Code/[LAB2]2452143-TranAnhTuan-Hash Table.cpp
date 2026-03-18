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
#define all(v) (v).begin(), (v).end()p
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

const int SIZE = 13;

struct Entry {
    string key;
    int value;
    bool used;
};

class HashTable {
private:
    Entry table[SIZE];

    int hashFunc(const string &key) {
        int hash = 0;
        for (char c : key) hash += c;
        return hash % SIZE;
    }

public:
    HashTable() {
        for (int i = 0; i < SIZE; ++i) table[i].used = false;
    }

    void insert(const string &key, int value) {
        int index = hashFunc(key);
        int start = index;
        while (table[index].used && table[index].key != key) {
            index = (index + 1) % SIZE;
            if (index == start) return;
        }
        table[index].key = key;
        table[index].value = value;
        table[index].used = true;
    }

    bool search(const string &key, int &value) {
        int index = hashFunc(key);
        int start = index;
        while (table[index].used) {
            if (table[index].key == key) {
                value = table[index].value;
                return true;
            }
            index = (index + 1) % SIZE;
            if (index == start) break;
        }
        return false;
    }

    void remove(const string &key) {
        int index = hashFunc(key);
        int start = index;
        while (table[index].used) {
            if (table[index].key == key) {
                table[index].used = false;
                cout << "Removed: " << key << endl;
                return;
            }
            index = (index + 1) % SIZE;
            if (index == start) break;
        }
        cout << "Key not found: " << key << endl;
    }

    void display() {
        cout << "\nHash Table:\n";
        for (int i = 0; i < SIZE; ++i) {
            if (table[i].used)
                cout << i << ": " << table[i].key << " -> " << table[i].value << endl;
            else
                cout << i << ": (empty)\n";
        }
    }
};

int main() {
    HashTable ht;
    ht.insert("apple", 10);
    ht.insert("banana", 2);
    ht.insert("cherry", 32);
    ht.display();

    int val;
    if (ht.search("banana", val))
        cout << "\nFound banana with value " << val << endl;
    else
        cout << "\nbanana not found\n";

    ht.remove("banana");
    ht.display();

    return 0;
}
