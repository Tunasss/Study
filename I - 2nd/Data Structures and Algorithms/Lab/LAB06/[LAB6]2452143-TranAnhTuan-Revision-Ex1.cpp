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

typedef struct aPlace{
    int hour, min;
    char locName[255];
    struct aPlace* next;
} PLACE;

int needMedicalReport(PLACE* visitedPlaces, char* reportLocName, int reportHour, int reportMin) {
    PLACE* cur = visitedPlaces;

    while (cur != nullptr) {
        if (strcmp(cur->locName, reportLocName) == 0) {
            if (cur->hour > reportHour ||
               (cur->hour == reportHour && cur->min > reportMin)) {

                return 1;
            }
        }
        cur = cur->next;
    }
    return 0;
}

void appendNode(PLACE*& head, int hour, int min, char* locName) {
    PLACE* newNode = new PLACE();
    newNode->hour = hour;
    newNode->min = min;
    strcpy(newNode->locName, locName);
    newNode->next = nullptr;

    if (head == nullptr) {
        head = newNode;
    } else {
        PLACE* temp = head;
        while (temp->next != nullptr) {
            temp = temp->next;
        }
        temp->next = newNode;
    }
}

int main() {
    ios::sync_with_stdio(0);
    cin.tie(0);
    cout.tie(0);

    int n;
    cin >> n;

    PLACE* head = nullptr;

    for (int i = 0; i < n; i++) {
        int h, m;
        char name[255];
        cin >> h >> m >> name;
        appendNode(head, h, m, name);
    }
    char reportLocName[255];
    int reportHour, reportMin;
    cin >> reportLocName >> reportHour >> reportMin;
    int result = needMedicalReport(head, reportLocName, reportHour, reportMin);

    cout << result << endl;

    return 0;
}
