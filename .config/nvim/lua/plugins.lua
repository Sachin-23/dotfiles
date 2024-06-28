local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "RRethy/base16-nvim",
    config = function()
      vim.cmd.colorscheme("base16-gruvbox-dark-hard")
      vim.api.nvim_set_hl(0, "Normal", {bg="#1b1b1b"})
      vim.api.nvim_set_hl(0, "LineNr", {bg="#1b1b1b"})
    end,
 },
 --{
 --  'nvim-lualine/lualine.nvim',
 --  dependencies = { 'nvim-tree/nvim-web-devicons' },
 --  config = function()
 --    require('lualine').setup({
 --      options = {
 --        theme = "base16",
 --        section_separators = '', 
 --        component_separators = ''
 --      }
 --    })
 --  end
 --},
 {
   "mbbill/undotree",
   config = function()
     vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
   end,
 },
 {
   "nvim-treesitter/nvim-treesitter",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "cpp" },
        auto_install = true,
        highlight = {
          enable = true,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      -- Don't start unless needed.
      lspconfig.clangd.setup({autostart = false})
      lspconfig.pylsp.setup({autostart = false})
      lspconfig.tsserver.setup({autostart = false})
      lspconfig.hls.setup({autostart = false})
      vim.api.nvim_set_keymap("n", "<Leader>c", ":LspStart<CR>", { noremap = true, silent = true })
    end
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup();
    end
  },
  {
    "mattn/emmet-vim",
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup();
    end
  },
  { 
    "junegunn/fzf", build = "./install --bin" 
  },
  { 
    "junegunn/fzf.vim"
  },
  {
    "tpope/vim-fugitive",
  },
})
