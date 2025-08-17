-- Snippet loader utility
-- This module loads all custom snippets and makes it easy to manage them

-- Check if LuaSnip is available before loading snippets
local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
    return
end

-- Load JavaScript snippets
require("pcf.snippets.javascript")

-- Load TypeScript snippets
require("pcf.snippets.typescript")

-- You can add more snippet files here as needed:
-- require("pcf.snippets.react")
-- require("pcf.snippets.vue")
-- require("pcf.snippets.python")
-- etc.
