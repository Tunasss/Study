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
class HashTable {
public:
    explicit HashTable(size_t buckets = 17) : m(buckets), table(m) {}

    // Insert key if it doesn't already exist
    bool insertKey(int key) {
        size_t i = index(key);
        if (containsInBucket(i, key)) return false;
        table[i].push_front(key);
        return true;
    }

    // Delete key if present
    bool deleteKey(int key) {
        size_t i = index(key);
        auto& bucket = table[i];
        auto before = bucket.before_begin();
        for (auto it = bucket.begin(); it != bucket.end(); ++it) {
            if (*it == key) {
                bucket.erase_after(before);
                return true;
            }
            ++before;
        }
        return false;
    }

    // Search key
    bool searchKey(int key) const {
        size_t i = index(key);
        for (int x : table[i]) if (x == key) return true;
        return false;
    }

    // Print all buckets
    void print() const {
        cout << "Hash table (" << m << " buckets):\n";
        for (size_t i = 0; i < m; ++i) {
            cout << i << ":";
            for (int x : table[i]) cout << " " << x;
            cout << "\n";
        }
    }

private:
    size_t m;
    vector<forward_list<int>> table;

    size_t index(int key) const {
        // make modulo work for negative integers too
        long long mod = static_cast<long long>(m);
        long long r = (static_cast<long long>(key) % mod + mod) % mod;
        return static_cast<size_t>(r);
    }

    bool containsInBucket(size_t i, int key) const {
        for (int x : table[i]) if (x == key) return true;
        return false;
    }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    size_t bucket_count = 17;
    HashTable ht(bucket_count);

    ht.insertKey(10);
    ht.insertKey(20);
    ht.insertKey(30);
    ht.insertKey(25);

    ht.print();

    ht.searchKey(25) ? cout << "Key 25 Found\n" : cout << "Key 25 Not found\n";
    ht.searchKey(15) ? cout << "Key 15 Found\n" : cout << "Key 15 Not found\n";

    ht.deleteKey(20);

    ht.print();
    return 0;
}