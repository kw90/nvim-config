return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local neo_tree = require("neo-tree")

		neo_tree.setup({
			source_selector = {
				winbar = true,
				statusline = false,
			},
			buffers = {
				follow_current_file = true, -- This will automatically navigate to the current file
			},
			git_status = {
				window = {
					position = "float",
				},
			},
			filesystem = {
				follow_current_file = true, -- This will automatically navigate to the current file
				hijack_netrw_behavior = "open_current", -- Open neo-tree when using netrw commands
				use_libuv_file_watcher = true, -- Automatically update the tree when files change
				filtered_items = {
					visible = false, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						".DS_Store",
						"thumbs.db",
						".git",
					},
					always_show = { -- remains visible even if other settings would normally hide it
						".gitignore",
					},
					never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
						".DS_Store",
						".DS_Store",
						"thumbs.db",
					},
				},
				window = {
					auto_resize = true, -- Automatically resize the window to fit its contents
					mappings = {
						["."] = "set_root",
						["<CR>"] = "open",
						["o"] = "open",
						["<2-LeftMouse>"] = "open",
						["<C-x>"] = "open_split",
						["<C-v>"] = "open_vsplit",
						["<C-t>"] = "open_tabnew",
						["<BS>"] = "navigate_up",
						["h"] = "close_node", -- Hide directory
						["l"] = "open", -- Show directory
						["H"] = "toggle_hidden",
						["R"] = "refresh",
						["<C-u>"] = "navigate_up", -- Navigate up the directory tree
						["Y"] = function(state)
							-- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
							-- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
							local node = state.tree:get_node()
							local filepath = node:get_id()
							local filename = node.name
							local modify = vim.fn.fnamemodify

							local results = {
								filepath,
								modify(filepath, ":."),
								modify(filepath, ":~"),
								filename,
								modify(filename, ":r"),
								modify(filename, ":e"),
							}

							vim.ui.select({
								"1. Absolute path: " .. results[1],
								"2. Path relative to CWD: " .. results[2],
								"3. Path relative to HOME: " .. results[3],
								"4. Filename: " .. results[4],
								"5. Filename without extension: " .. results[5],
								"6. Extension of the filename: " .. results[6],
							}, { prompt = "Choose to copy to clipboard:" }, function(choice)
								local i = tonumber(choice:sub(1, 1))
								local result = results[i]
								vim.fn.setreg('+', result)
								vim.notify("Copied: " .. result)
							end)
						end,
					},
				},
			},
		})
		vim.keymap.set("n", "<leader>e", function()
			vim.cmd(
				"Neotree toggle position=left action=focus dir=" .. require("project_nvim.project").get_project_root()
			)
		end, { noremap = true, silent = true })
	end,
}
