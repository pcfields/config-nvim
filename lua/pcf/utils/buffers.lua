local M = {}

local Icons = {
	MODIFIED = " 🟠 ",
	UNMODIFIED = " ⚫️ ",
}

local Colors = {
	bright_green = "#00ff00",
	pale_blue = "#78a9ff",
	gray_light = "#4d5c7b",
}

-- Function to get the number of open buffers using the :ls command
function M.get_buffer_count()
	local open_buffers = vim.fn.execute("ls") -- ls is equal to buffers
	local count = 0

	-- Match only lines that represent buffers, typically starting with a number followed by a space
	for line in string.gmatch(open_buffers, "[^\r\n]+") do
		if string.match(line, "^%s*%d+") then
			count = count + 1
		end
	end

	return count
end

function M.get_winbar_filename()
	vim.api.nvim_set_hl(0, "FilenameColor", { fg = Colors.pale_blue })
	vim.api.nvim_set_hl(0, "BrightGreenColor", { fg = Colors.bright_green, bold = true })
	vim.api.nvim_set_hl(0, "FilePathDimColor", { fg = Colors.gray_light, bold = true })

	local file_path = vim.api.nvim_eval_statusline("%f", {}).str
	local open_buffers_count = M.get_buffer_count()
	local is_buffer_modified = vim.api.nvim_eval_statusline("%m", {}).str == "[+]"
	local modified_buffer_icon = is_buffer_modified and Icons.MODIFIED or Icons.UNMODIFIED

	local directory_path = vim.fn.fnamemodify(file_path, ":h") -- Directory (head, no filename)
	local filename = vim.fn.fnamemodify(file_path, ":t")      -- Tail (filename only)

	local open_buffers_count_formatted = "(" .. open_buffers_count .. ") "
	local dimmed_directory_path = "%#FilePathColor#" .. directory_path .. "/"
	local bright_filename = "%#BrightGreenColor#" .. filename

	return "%#BrightGreenColor#" ..
			modified_buffer_icon .. open_buffers_count_formatted .. dimmed_directory_path .. bright_filename
end

return M
