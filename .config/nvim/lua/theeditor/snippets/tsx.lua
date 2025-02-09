require("luasnip.session.snippet_collection").clear_snippets("elixir")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local r = require("luasnip.extras").rep

local fmt = require("luasnip.extras.fmt").fmt

local vi = s("vi", fmt("vector<@`> @`", { i(1, "int"), i(0) }, { delimiters = "@`" }))
local fc = s(
	"fc",
	fmt(
		[[
import { FC } from 'react'

interface @`Props {

}

const @`: FC<@`Props> = ({}) => {
  return <div>@`</div>
}

export default @`
]],
		{ i(0), r(0), r(0), i(1), r(0) },
		{ delimiters = "@`" }
	)
)

ls.add_snippets("typescriptreact", {
	fc,
	vi,
})
