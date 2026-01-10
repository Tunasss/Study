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
#define er equal_range
#define bin binary_search
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

const ll N = 5e3 + 5;
const ll oo = 2e15 + 5;

struct Customer {
	string id;      // up to 10 chars
	string name;
	string station;
	double price;
	Customer() : price(0.0) {}
	Customer(string _id, string _name, string _station, double _price)
		: id(move(_id)), name(move(_name)), station(move(_station)), price(_price) {}
};

struct Node {
	Customer data;
	Node* prev;
	Node* next;
	Node(const Customer& c) : data(c), prev(nullptr), next(nullptr) {}
};

class DoublyLinkedList {
private:
	Node* head;
	Node* tail;
public:
	DoublyLinkedList() : head(nullptr), tail(nullptr) {}
	~DoublyLinkedList() { clear(); }

	bool empty() const { return head == nullptr; }

	// find by id
	Node* find(const string& id) const {
		Node* cur = head;
		while (cur) {
			if (cur->data.id == id) return cur;
			cur = cur->next;
		}
		return nullptr;
	}

	bool push_back_if_new(const Customer& c) {
		if (find(c.id)) return false;
		Node* node = new Node(c);
		if (!tail) {
			head = tail = node;
		} else {
			tail->next = node;
			node->prev = tail;
			tail = node;
		}
		return true;
	}

	bool remove_by_id(const string& id) {
		Node* node = find(id);
		if (!node) return false;
		if (node->prev) node->prev->next = node->next; else head = node->next;
		if (node->next) node->next->prev = node->prev; else tail = node->prev;
		delete node;
		return true;
	}

	// pop front (sell ticket to first registered)
	bool pop_front(Customer &out) {
		if (!head) return false;
		Node* node = head;
		out = node->data;
		head = node->next;
		if (head) head->prev = nullptr; else tail = nullptr;
		delete node;
		return true;
	}

	void display() const {
		cout << left << setw(12) << "ID" << setw(25) << "Name" << setw(20) << "Station" << setw(10) << "Price" << '\n';
		cout << string(70, '-') << '\n';
		Node* cur = head;
		while (cur) {
			cout << left << setw(12) << cur->data.id
			     << setw(25) << cur->data.name
			     << setw(20) << cur->data.station
			     << fixed << setprecision(2) << setw(10) << cur->data.price << '\n';
			cur = cur->next;
		}
	}

	void clear() {
		Node* cur = head;
		while (cur) {
			Node* nx = cur->next;
			delete cur;
			cur = nx;
		}
		head = tail = nullptr;
	}

	// iterate helper
	template<typename F>
	void for_each(F f) const {
		Node* cur = head;
		while (cur) { f(cur->data); cur = cur->next; }
	}
};

// helpers
static inline string trim(const string &s) {
	size_t a = s.find_first_not_of(" \t\r\n");
	if (a == string::npos) return string();
	size_t b = s.find_last_not_of(" \t\r\n");
	return s.substr(a, b - a + 1);
}

bool loadFromFile(DoublyLinkedList &list, const string &filename) {
	ifstream in(filename);
	if (!in) return false;
	string line;
	while (getline(in, line)) {
		if (line.empty()) continue;
		vector<string> parts;
		string cur;
		stringstream ss(line);
		while (getline(ss, cur, ';')) parts.push_back(trim(cur));
		if (parts.size() < 4) continue;
		double price = 0.0;
		try { price = stod(parts[3]); } catch (...) { price = 0.0; }
		Customer c(parts[0], parts[1], parts[2], price);
		list.push_back_if_new(c);
	}
	return true;
}

bool saveToFile(const DoublyLinkedList &list, const string &filename) {
	ofstream out(filename);
	if (!out) return false;
	list.for_each([&out](const Customer & c) {
		out << c.id << ";" << c.name << ";" << c.station << ";" << c.price << '\n';
	});
	return true;
}

int main() {
	DoublyLinkedList list;
	long long soldCount = 0;
	double totalRevenue = 0.0;
	string input;

	while (true) {
		cout << "\n=== Train Ticket Queue Menu ===\n";
		cout << "1. Load waiting list from file\n";
		cout << "2. Add new customer to queue\n";
		cout << "3. Sell ticket to first customer\n";
		cout << "4. Display customer list\n";
		cout << "5. Remove customer by ID\n";
		cout << "6. Statistics of ticket sales\n";
		cout << "7. Save list to file\n";
		cout << "8. Display list of stations currently being waited for\n";
		cout << "9. Display stations with number of waiting customers\n";
		cout << "0. Exit\n";
		cout << "Choose an option: ";
		if (!getline(cin, input)) break;
		int opt = -1;
		try { opt = stoi(input); } catch (...) { opt = -1; }

		if (opt == 0) break;

		if (opt == 1) {
			cout << "Enter filename to load: ";
			string fn; getline(cin, fn);
			if (loadFromFile(list, fn))
				cout << "Loaded from " << fn << '\n'; else cout << "Failed to open " << fn << '\n';
		} else if (opt == 2) {
			Customer c;
			cout << "Enter ID: ";
			getline(cin, c.id);
			if (c.id.empty()) {
				cout << "ID cannot be empty\n";
				continue;
			}
			if (list.find(c.id)) {
				cout << "Customer with this ID already exists.\n";
				continue;
			}
			cout << "Enter Name: ";
			getline(cin, c.name);
			cout << "Enter Destination Station: ";
			getline(cin, c.station);
			cout << "Enter Ticket Price: "; 
			string p;
			getline(cin, p);
			try {
				c.price = stod(p);
			} catch (...) {
				c.price = 0.0;
			}
			if (list.push_back_if_new(c)) cout << "Customer added.\n";
			else cout << "Failed to add (duplicate?).\n";
		} else if (opt == 3) {
			Customer c;
			if (list.pop_front(c)) {
				soldCount++;
				totalRevenue += c.price;
				cout << "Sold ticket to: " << c.name << " (ID=" << c.id << ") Price=" << fixed << setprecision(2) << c.price << '\n';
			} else cout << "No customers in queue.\n";
		} else if (opt == 4) {
			if (list.empty()) 
				cout << "No customers in queue.\n"; 
			else list.display();
		} else if (opt == 5) {
			cout << "Enter ID to remove: "; 
			string id; 
			getline(cin, id);
			if (list.remove_by_id(id)) 
				cout << "Customer removed.\n"; 
			else cout << "Customer not found.\n";
		} else if (opt == 6) {
			cout << "Tickets sold: " << soldCount << "\n";
			cout << "Total revenue: " << fixed << setprecision(2) << totalRevenue << "\n";
			if (soldCount > 0) cout << "Average price: " << (totalRevenue / soldCount) << "\n";
		} else if (opt == 7) {
			cout << "Enter filename to save: "; string fn; getline(cin, fn);
			if (saveToFile(list, fn)) cout << "Saved to " << fn << '\n'; else cout << "Failed to save to " << fn << '\n';
		} else if (opt == 8) {
			set<string> stations;
			list.for_each([&stations](const Customer & c) { stations.insert(c.station); });
			if (stations.empty()) cout << "No stations currently waited for.\n"; else {
				cout << "Stations waited for:\n";
				for (const auto &s : stations) cout << "- " << s << '\n';
			}
		} else if (opt == 9) {
			unordered_map<string, int> cnt;
			list.for_each([&cnt](const Customer & c) { cnt[c.station]++; });
			if (cnt.empty()) cout << "No stations currently waited for.\n"; else {
				cout << left << setw(30) << "Station" << "Count\n";
				cout << string(40, '-') << '\n';
				for (auto &p : cnt) cout << left << setw(30) << p.first << p.second << '\n';
			}
		} else {
			cout << "Invalid option.\n";
		}
	}

	cout << "Exiting.\n";
	return 0;
}