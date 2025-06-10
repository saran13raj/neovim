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
  s('rfc1', {
    t { "import React from 'react';", '', '' },
    t 'export const ',
    i(1, 'ComponentName'),
    t ': React.FC = () => {',
    t { '', '\treturn (' },
    t { '', '\t\t<div>' },
    i(2),
    t { '</div>', '\t);', '}' },
  }),
}
