vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.termguicolors = true

local lspconfig = require("lspconfig")
lspconfig.gopls.setup({
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature help" })

local cmp = require("cmp")
cmp.setup({
    source = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    },
    mapping = cmp.mapping.preset.insert({
	["<C-Space>"] = cmp.mapping.complete(),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["Right"] = function(fallback)
            fallback()
        end,
        ["Tab"] = function(fallback)
	    fallback()
        end,
    }),
})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "lua" },
	highlight = { enable = true },
})

require("toggleterm").setup({
	size = 12,
	open_mapping = [[<C-\>]],
	direction = "horizontal",
	shade_terminals = false,
})

require("nvim-tree").setup({
    actions = {
        open_file = {
            quit_on_open = false,
            window_picker = { enable = false },
        },
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "NvimTree",
    callback = function()
        local api = require("nvim-tree.api")
        vim.keymap.set("n", "<CR>", api.node.open.tab, { buffer = true, noremap = true, silent = true })
    end,
})

vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find text" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Open buffer" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help" })

vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Find references" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Go to implementation" })

require("bufferline").setup({
    options = {
        numbers = "none",
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
    },
})

vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>bd", function()
    local current = vim.api.nvim_get_current_buf(),
    vim.cmd("BufferLineCyclePrev")
    vim.cmd("bdelete " .. current)
end, { desc = "Close buffer and go prev" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostics under cursor" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, { desc = "Diagnostics list" })

require("go").setup({
    gofmt = "gofumpt",
    tag_transform = false,
    verbose = false,
    lsp_cfg = true,
    lsp_gofumpt = true,
    lsp_inlay_hints = { enable = false },
    lsp_cfg_extra = {
	settings = {
            gopls = {
              	gofumpt = true,
              	usePlaceholders = false,
              	analyses = {
                    unusedparams = true,
		},
              	staticchek = true,
            },
    	},
    },
})

