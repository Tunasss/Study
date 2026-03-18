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
    map<string, int> myMap;

    myMap["apple"] = 10;
    myMap["banana"] = 20;
    myMap["cherry"] = 30;

    cout << "Map contents:" << endl;
    for (const auto &pair : myMap) {
        cout << pair.first << ": " << pair.second << endl;
    }

    string key = "banana";
    if (myMap.find(key) != myMap.end()) {
        cout << key << " found with value: " << myMap[key] << endl;
    } else {
        cout << key << " not found." << endl;
    }

    myMap.erase("apple");
    cout << "After deleting 'apple':" << endl;
    for (const auto &pair : myMap) {
        cout << pair.first << ": " << pair.second << endl;
    }

    return 0;
}