vim.opt.number = true
-- vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop =2
vim.opt.expandtab = true

vim.opt.ruler = true
vim.opt.wrap = true

vim.opt.smartcase = true

vim.opt.virtualedit = "block"

-- Search and replace
vim.opt.inccommand = "split"
vim.opt.ignorecase = true

vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.guicursor = ""
vim.opt.showmode = false
--vim.opt.cmdheight = 0
vim.opt.laststatus = 0

vim.opt.scrolloff = 1

-- vim.opt.clipboard = "unnamedplus"
-- vim.opt.scrolloff = 999

vim.opt.termguicolors = true

-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("x", "<leader>p", "\"_dP")

USER = os.getenv("USER")

SWAPDIR = "/home/" .. USER .. "/.cache/nvim/.config/nvim/swap//"
BACKUPDIR = "/home/" .. USER .. "/.cache/nvim/.config/nvim/swap//"
UNDODIR = "/home/" .. USER .. "/.cache/nvim/.config/nvim/swap//"

if vim.fn.isdirectory(SWAPDIR) == 0 then
	vim.fn.mkdir(SWAPDIR, "p", "0o700")
end

if vim.fn.isdirectory(BACKUPDIR) == 0 then
	vim.fn.mkdir(BACKUPDIR, "p", "0o700")
end

if vim.fn.isdirectory(UNDODIR) == 0 then
	vim.fn.mkdir(UNDODIR, "p", "0o700")
end

-- Enable swap, backup, and persistant undo
vim.opt.directory = SWAPDIR
vim.opt.backupdir = BACKUPDIR
vim.opt.undodir = UNDODIR
vim.opt.swapfile = true
vim.opt.backup = true
vim.opt.undofile = true
vim.opt.mouse = ""

-- Append backup files with timestamp
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
		vim.o.backupext = extension
	end,
})

-- use space as a the leader key
-- vim.g.mapleader = ' '

vim.o.updatetime = 1000;

-- Create an autocmd group for LSP document highlight
vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
  group = "LspDocumentHighlight",
  buffer = 0,
	callback = function()
		vim.lsp.buf.document_highlight()
	end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  group = "LspDocumentHighlight",
  buffer = 0,
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})
