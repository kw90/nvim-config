-- Set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

local keymap = vim.keymap -- for conciseness

-- Enhanced cross-platform clipboard configuration
local function setup_clipboard()
    -- Detect platform
    local is_wsl = vim.fn.has('wsl') == 1 or
        vim.fn.exists('$WSL_DISTRO_NAME') == 1 or
        vim.fn.exists('$WSLENV') == 1
    local is_mac = vim.fn.has('mac') == 1 or vim.fn.has('macunix') == 1
    local is_linux = vim.fn.has('unix') == 1 and not is_mac and not is_wsl

    if is_wsl then
        -- WSL configuration
        vim.opt.clipboard = 'unnamedplus'
        vim.g.clipboard = {
            name = 'WslClipboard',
            copy = {
                ['+'] = 'clip.exe',
                ['*'] = 'clip.exe',
            },
            paste = {
                ['+'] = 'powershell.exe -noprofile -command "Get-Clipboard"',
                ['*'] = 'powershell.exe -noprofile -command "Get-Clipboard"',
            },
            cache_enabled = false,
        }
    elseif is_mac then
        -- macOS configuration
        vim.opt.clipboard = 'unnamed,unnamedplus'
        -- macOS has built-in pbcopy/pbpaste support
    elseif is_linux then
        -- Linux configuration
        vim.opt.clipboard = 'unnamedplus'

        -- Prefer wl-clipboard for Wayland, fallback to xclip for X11
        if vim.env.XDG_SESSION_TYPE == 'wayland' and vim.fn.executable('wl-copy') == 1 then
            vim.g.clipboard = {
                name = 'wl-clipboard',
                copy = {
                    ['+'] = 'wl-copy',
                    ['*'] = 'wl-copy --primary',
                },
                paste = {
                    ['+'] = 'wl-paste --no-newline',
                    ['*'] = 'wl-paste --no-newline --primary',
                },
                cache_enabled = true,
            }
        elseif vim.fn.executable('xclip') == 1 then
            vim.g.clipboard = {
                name = 'xclip',
                copy = {
                    ['+'] = 'xclip -quiet -i -selection clipboard',
                    ['*'] = 'xclip -quiet -i -selection primary',
                },
                paste = {
                    ['+'] = 'xclip -o -selection clipboard',
                    ['*'] = 'xclip -o -selection primary',
                },
                cache_enabled = true,
            }
        elseif vim.fn.executable('xsel') == 1 then
            vim.g.clipboard = {
                name = 'xsel',
                copy = {
                    ['+'] = 'xsel --nodetach --input --clipboard',
                    ['*'] = 'xsel --nodetach --input --primary',
                },
                paste = {
                    ['+'] = 'xsel --output --clipboard',
                    ['*'] = 'xsel --output --primary',
                },
                cache_enabled = true,
            }
        end
    else
        -- Fallback for unknown systems
        vim.opt.clipboard = 'unnamedplus'
    end
end

-- Apply the configuration
setup_clipboard()


-- General keymaps --
-- clear search highlights
keymap.set("n", "<leader>nh", "<cmd>nohl<cr>", { desc = "Clear search highlights" })

-- yank to system clipboard using leader key
keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })

-- Move up and down by visual (wrapped) lines
keymap.set("n", "j", "gj", { noremap = true, silent = true })
keymap.set("n", "k", "gk", { noremap = true, silent = true })

-- Toggle wrap mode
local function toggle_wrap_mode()
    local window_options = vim.wo -- for conciseness

    -- Toggle options
    window_options.wrap = not window_options.wrap
    window_options.linebreak = not window_options.linebreak
    window_options.cursorline = not window_options.cursorline

    print("Toggled wrap", window_options.wrap)
end
keymap.set("n", "<leader>w", toggle_wrap_mode, { desc = "Toggle wrap" })

-- Buffer management
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap.set("n", "<C-x>", "<cmd>BufDel<cr>", { desc = "Close Buffer" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- Visuals when scrolling and moving things around
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Avoid overwriting yank
keymap.set("x", "p", "P")
-- Remap <leader>p to the original p (paste from the clipboard) in visual mode
keymap.set("x", "<leader>p", "p")

-- Replace
keymap.set("n", "<C-s>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Plugins keymaps --
vim.keymap.set("n", "<leader>ca", function()
    require("tiny-code-action").code_action()
end, { noremap = true, silent = true })
