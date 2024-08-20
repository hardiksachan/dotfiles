require("luasnip.session.snippet_collection").clear_snippets("cpp")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

local template = s(
	"beg",
	fmt(
		[[
#ifdef ONPC
  #define _GLIBCXX_DEBUG
#endif

#include <bits/stdc++.h>
#define sz(a) ((int)((a).size()))
#define char unsigned char

using namespace std;
// mt19937 rnd(239);
mt19937 rnd(chrono::steady_clock::now().time_since_epoch().count());

typedef long long ll;
typedef long double ld;

int testcase() {
  @`
	return 0;
}

int32_t main() {
	ios::sync_with_stdio(0);
	cin.tie(0);
  #ifdef ONPC
  freopen("input.txt", "r", stdin);
  freopen("output.txt", "w", stdout);
  #endif

	int TET = 1;
	cin >> TET;
	for (int i = 1; i <= TET; i++) {
		if (testcase()) {
			break;
		}
		#ifdef ONPC
			cout << "---------------------------------------------" << endl;
		#endif
	}
	#ifdef ONPC
		cerr << endl << "finished in " << clock() * 1.0 / CLOCKS_PER_SEC << " sec" << endl;
	#endif
}
]],
		{ i(0) },
		{ delimiters = "@`" }
	)
)

local mininal_template = s(
	"minimal",
	fmt(
		[[
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;

int32_t main() {
  @`
}
]],
		{ i(0) },
		{ delimiters = "@`" }
	)
)

local vvi = s("vvi", fmt("vector<vector<@`>> @`", { i(1, "int"), i(0) }, { delimiters = "@`" }))

local vi = s("vi", fmt("vector<@`> @`", { i(1, "int"), i(0) }, { delimiters = "@`" }))

local ii = s("ii", fmt("pair<@`, @`> @`", { i(1, "int"), i(2, "int"), i(0) }, { delimiters = "@`" }))

local iii =
	s("iii", fmt("tuple<@`, @`, @`> @`", { i(1, "int"), i(2, "int"), i(3, "int"), i(0) }, { delimiters = "@`" }))

local four_directions = s(
	"4dir",
	fmt("vector<pair<int, int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};\n@`", { i(0) }, { delimiters = "@`" })
)

local eight_directions = s(
	"8dir",
	fmt(
		"vector<pair<int, int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};\n@`",
		{ i(0) },
		{ delimiters = "@`" }
	)
)

local union_find = s(
	"uf",
	fmt(
		[[
class union_find {
private:
  vector<int> size;
  vector<int> parent;
  int component_count ;

public:
  union_find(int n) {
    size.resize(n);
    parent.resize(n);
    for (int i = 0; i < n; i++) {
      size[i] = 1;
      parent[i] = i;
    }
    component_count = n;
  }

  int find(int i) {
    if (parent[i] == i)
      return i;

    return parent[i] = find(parent[i]);
  }

  void merge(int i, int j) {
    int pi = find(i);
    int pj = find(j);

    if (pi == pj)
      return;

    if (size[pi] > size[pj]) {
      size[pi] += size[pj];
      parent[pj] = pi;
    } else {
      size[pj] += size[pi];
      parent[pi] = pj;
    }
    component_count--;
  }

  bool connected(int i, int j) { return find(i) == find(j); }

  int components() {
    return component_count;
  }
};
@`]],
		{ i(0) },
		{ delimiters = "@`" }
	)
)

local treenode = s(
	"treenode",
	fmt(
		[[
struct TreeNode {
  int val;
  TreeNode *left;
  TreeNode *right;
  TreeNode() : val(0), left(nullptr), right(nullptr) {}
  TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
  TreeNode(int x, TreeNode *left, TreeNode *right)
      : val(x), left(left), right(right) {}
  TreeNode(vector<int> &levelOrder) {
    if (levelOrder.empty()) {
      return;
    }
    val = levelOrder[0];
    queue<TreeNode *> q;
    q.push(this);
    for (int i = 1; i < sz(levelOrder); i += 2) {
      TreeNode *cur = q.front();
      q.pop();
      if (levelOrder[i] != -1) {
        cur->left = new TreeNode(levelOrder[i]);
        q.push(cur->left);
      }
      if (i + 1 < sz(levelOrder) && levelOrder[i + 1] != -1) {
        cur->right = new TreeNode(levelOrder[i + 1]);
        q.push(cur->right);
      }
    }
  }
};
@`]],
		{ i(0) },
		{ delimiters = "@`" }
	)
)

ls.add_snippets("cpp", {
	template,
	mininal_template,
	vi,
	vvi,
	ii,
	iii,
	four_directions,
	eight_directions,
	union_find,
	treenode,
})
