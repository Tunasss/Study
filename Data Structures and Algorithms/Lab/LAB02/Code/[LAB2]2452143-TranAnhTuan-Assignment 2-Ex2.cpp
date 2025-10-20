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

int main() {
    string s;
    cin >> s;

    stack<char> myStack;

    for (char c : s) {
        if (c == '(' || c == '[' || c == '{') { // If the character is an opening bracket, push it onto the stack
            myStack.push(c);
        } else {  // Otherwise, it must be a closing bracket
            if (myStack.empty()) { // If there's no opening bracket to match
                cout << "Invalid\n";
                return 0;
            }
            char t = myStack.top(); // Get the top (most recent) opening bracket
            myStack.pop(); // Remove it from the stack

            // Check if the current closing bracket matches the opening one
            if ((c == ')' && t != '(') || 
                (c == ']' && t != '[') || 
                (c == '}' && t != '{')) {
                cout << "Invalid\n";
                return 0;
            }
        }
    }

    /* After processing all characters: If the stack is empty → all brackets were matched properly
    Otherwise → some opening brackets were not closed */

    cout << (myStack.empty() ? "Valid\n" : "Invalid\n");

    return 0;
}
