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
    list<int> myList;

    myList.push_back(10);
    myList.push_back(20);
    myList.push_back(30);

    cout << "List contents:" << endl;
    for (const auto &item : myList) {
        cout << item << " ";
    }
    cout << endl;

    int key = 20;
    auto it = find(myList.begin(), myList.end(), key);
    if (it != myList.end()) {
        cout << key << " found in the list." << endl;
    } else {
        cout << key << " not found in the list." << endl;
    }

    myList.remove(10);
    cout << "After deleting 10:" << endl;
    for (const auto &item : myList) {
        cout << item << " ";
    }
    cout << endl;

    return 0;
}