local tex = require("lilleaila-snippets.helpers.tex")
local utils = require("lilleaila-snippets.helpers.utils")
local tsnip = tex.tsnip
local _tsnip = tex._tsnip
local msnip = tex.msnip
local _msnip = tex._msnip

require("lilleaila-snippets.helpers.ls").load_vars()

local M = {
  tsnip({ trig = "!init!", name = "initialize new document" }, [[
    \newcommand*{\shared}{../shared}
    \input{\shared/p-document.tex}

    \title{$1}
    \date{$2}
    \author{Olai Solsvik}

    \begin{document}
    \maketitle
    \tableofcontents
    \hr

    $3

    \end{document}
  ]])
}

return M