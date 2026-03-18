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
unordered_map<string, string> dict;
struct TrieNode {
    TrieNode* children[26];
    bool isEndOfWord;
    TrieNode() {
        isEndOfWord = false;
        for (int i = 0; i < 26; i++)
            children[i] = nullptr;
    }
};
class Trie {
private:
    TrieNode* root;
public:
    Trie() {
        root = new TrieNode();
    }

    void insert(const string& word) {
        TrieNode* node = root;
        for (char ch : word) {
            int index = ch - 'a';
            if (!node->children[index])
                node->children[index] = new TrieNode();
            node = node->children[index];
        }
        node->isEndOfWord = true;
    }

    void suggestionsRec(TrieNode* node, string prefix, vector<string>& results) {
        if (node->isEndOfWord)
            results.push_back(prefix);
        for (int i = 0; i < 26; i++) {
            if (node->children[i]) {
                suggestionsRec(node->children[i], prefix + char(i + 'a'), results);
            }
        }
    }

    vector<string> getSuggestions(const string& prefix) {
        TrieNode* node = root;
        vector<string> results;
        for (char ch : prefix) {
            int index = ch - 'a';
            if (!node->children[index])
                return results;
            node = node->children[index];
        }
        suggestionsRec(node, prefix, results);
        return results;
    }

    void find(const string& word) {
        TrieNode* node = root;
        for (char ch : word) {
            int index = ch - 'a';
            if (index < 0 || index >= 26 || !node->children[index]) {
                cout << "Not found\n";
                return;
            }
            node = node->children[index];
        }
        if (node->isEndOfWord) {
            auto it = dict.find(word);
            if (it != dict.end())
                cout << word << " -> " << it->second << '\n';
            else
                cout << "Not found\n";
        } else {
            cout << "Not found\n";
        }
    }
};
int main() {
    ios::sync_with_stdio(0);
    cin.tie(0); cout.tie(0);
    //freopen(file".inp","r",stdin);
    //freopen(file".out","w",stdout);

    Trie myTrie;
    myTrie.insert("hello");
    myTrie.insert("help");
    myTrie.insert("hero");
    dict["hello"] = "xin_chao";
    dict["help"] = "giup_do";
    dict["hero"] = "anh_hung";

    myTrie.find("hello");
    myTrie.find("hi");

    vector<string> suggestions = myTrie.getSuggestions("he");
    for (const string& word : suggestions) {
        cout << word << " ";
    }
}
