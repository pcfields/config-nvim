local M = {}

local function get_first_char_of_node(treesitter_node)
	local CURRENT_BUFFER = 0

	local start_row, start_col, _, _ = treesitter_node:range()
	local ending_row = start_row + 1
	local is_newline_included = false

	local current_node_line = vim.api.nvim_buf_get_lines(CURRENT_BUFFER, start_row, ending_row, is_newline_included)[1]
	local first_char_of_line = current_node_line:sub(start_col + 1, start_col + 1)

	return first_char_of_line
end

local function get_suffix_for_string_node(treesitter_node)
	local first_char_of_line = get_first_char_of_node(treesitter_node)

	return first_char_of_line == "'" and "'" or '"'
end

local node_type_command_suffixes = {
	array = "[",
	subscript_expression = "[",
	object = "{",
	object_pattern = "{",
	object_type = "{",
	interface_declaration = "{",
	enum_declaration = "{",
	statement_block = "{",
	template_substitution = "{",
	jsx_expression = "{",
	named_imports = "{",
	type_parameters = "<",
	type_parameter = "<",
	type_arguments = "<",
	jsx_self_closing_element = "<",
	jsx_opening_element = "<",
	formal_parameters = "(",
	arguments = "(",
	argument = "(",
	for_statement = "(",
	parenthesized_expression = "(",
	template_string = "`",
	string = get_suffix_for_string_node,
}

local function get_command_suffix(treesitter_node)
	local node_type = treesitter_node:type()
	local command_suffix = node_type_command_suffixes[node_type]

	if type(command_suffix) == "function" then
		command_suffix = command_suffix(treesitter_node)
	end

	return command_suffix
end

local function get_treesitter_node_at_cursor()
	return require("nvim-treesitter.ts_utils").get_node_at_cursor()
end

function M.execute_command_on_enclosing_node(command)
	local treesitter_node = get_treesitter_node_at_cursor()

	while treesitter_node do
		local command_suffix = get_command_suffix(treesitter_node)

		if command_suffix then
			-- Execute the command with the suffix .e.g `di{` or `yi{`
			vim.cmd("normal! " .. command .. command_suffix)
			return
		end

		treesitter_node = treesitter_node:parent()
	end
end

return M
