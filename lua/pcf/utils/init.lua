local M = {}

function M.map(mode, lhs, rhs, opts)
	-- Initialize opts if it's not provided
	if opts == nil then
		opts = {}
	end

	-- Set default values for opts
	if opts.silent == nil then
		opts.silent = true
	end

	if opts.noremap == nil then
		opts.noremap = true
	end

	-- Create the mapping
	vim.keymap.set(mode, lhs, rhs, opts)
end

return M
