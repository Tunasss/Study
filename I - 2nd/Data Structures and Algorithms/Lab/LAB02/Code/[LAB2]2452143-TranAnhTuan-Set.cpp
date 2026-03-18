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

int main() {
    set<int> mySet;

    mySet.insert(10);
    mySet.insert(20);
    mySet.insert(30);

    cout << "Set contents:" << endl;
    for (const auto &item : mySet) {
        cout << item << " ";
    }
    cout << endl;

    int key = 20;
    if (mySet.find(key) != mySet.end()) {
        cout << key << " found in the set." << endl;
    } else {
        cout << key << " not found in the set." << endl;
    }

    mySet.erase(10);
    cout << "After deleting 10:" << endl;
    for (const auto &item : mySet) {
        cout << item << " ";
    }
    cout << endl;

    return 0;
}