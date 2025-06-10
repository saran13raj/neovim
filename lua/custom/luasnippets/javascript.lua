local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s('clg1', {
    t 'console.log(',
    i(1), -- cursor will be placed here inside ()
    t ');',
  }),
}
