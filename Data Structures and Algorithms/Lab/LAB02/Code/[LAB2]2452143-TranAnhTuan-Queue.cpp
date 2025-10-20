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

template <typename T>
class Queue
{
private:
    vector<T> elements;
public:
    Queue() {}
    ~Queue() {}
    void enqueue(T val)
    {
        elements.push_back(val);
    }
    void dequeue()
    {
        if (!elements.empty()) elements.erase(elements.begin());
    }
    T front()
    {
        if (!elements.empty()) return elements.front();
        throw out_of_range("Queue is empty");
    }
    bool empty()
    {
        return elements.empty();
    }
    int size()
    {
        return elements.size();
    }
};

int main()
{
    Queue<int> q;
    q.enqueue(10);
    q.enqueue(20);
    q.enqueue(30);
    cout << "Front element: " << q.front() << endl; // Output: 10
    q.dequeue();
    cout << "Front element after dequeue: " << q.front() << endl; // Output: 20
    cout << "Queue size: " << q.size() << endl; // Output: 2
    return 0;
}