-- JavaScript Snippets - Minimal Essential Set
local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
    return
end

local snippet = luasnip.snippet
local insert_node = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

luasnip.add_snippets("javascript", {
    -- Console functions
    snippet("cl", fmt("console.log({});", { insert_node(1, "value") })),
    snippet("clo", fmt("console.log({{ {} }});", { insert_node(1, "name") })),
    snippet("ce", fmt("console.error({});", { insert_node(1, "error") })),
    snippet("cw", fmt("console.warn({});", { insert_node(1, "warning") })),
    snippet("cd", fmt("console.debug({});", { insert_node(1, "debug") })),
    snippet("ct", fmt("console.table({});", { insert_node(1, "data") })),

    -- Functions
    snippet("fn", fmt("function {}({}) {{\n\t{}\n}}", {
        insert_node(1, "name"),
        insert_node(2, ""),
        insert_node(3, "")
    })),

    -- Arrow functions
    snippet("af", fmt("const {} = ({}) => {{\n\t{}\n}};", {
        insert_node(1, "name"),
        insert_node(2, ""),
        insert_node(3, "")
    })),

    snippet("afs", fmt("const {} = ({}) => {};", {
        insert_node(1, "name"),
        insert_node(2, ""),
        insert_node(3, "")
    })),

    -- Test blocks
    snippet("desc", fmt("describe('{}', () => {{\n\t{}\n}});", {
        insert_node(1, "description"),
        insert_node(2, "")
    })),

    snippet("it", fmt("it('{}', () => {{\n\t{}\n}});", {
        insert_node(1, "should do something"),
        insert_node(2, "")
    })),

    snippet("test", fmt("test('{}', () => {{\n\t{}\n}});", {
        insert_node(1, "should do something"),
        insert_node(2, "")
    })),

    -- Async test blocks
    snippet("ita", fmt("it('{}', async () => {{\n\t{}\n}});", {
        insert_node(1, "should do something"),
        insert_node(2, "")
    })),

    snippet("testa", fmt("test('{}', async () => {{\n\t{}\n}});", {
        insert_node(1, "should do something"),
        insert_node(2, "")
    })),
})
