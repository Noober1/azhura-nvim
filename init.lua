-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"

-- Plugins
require("lazy").setup({
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd("colorscheme tokyonight-night")
    end,
  },

  -- File explorer (buffer-based)
  {
    "stevearc/oil.nvim",
    opts = {
      keymaps = {
        ["i"] = "actions.parent",
        ["k"] = "actions.select",
      },
      view_options = { show_hidden = true },
    },
  },

  -- Sidebar file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["i"] = "prev_item",
          ["k"] = "next_item",
          ["I"] = "noop",
          ["K"] = "noop",
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
      },
    },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
    },
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      theme = "tokyonight",
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- LSP & Completion
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("config.lsp")
    end,
  },

  -- Treesitter (syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
    },
  },

  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup()
    end,
  },

  -- Keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,
    },
  },

  -- Diagnostics UI
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
    },
  },

  -- Emmet
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    init = function()
      vim.g.user_emmet_leader_key = "<C-e>"
      vim.g.user_emmet_settings = {
        javascriptreact = { extends = "jsx" },
        typescriptreact = { extends = "jsx" },
      }
    end,
  },

  -- AI code completion
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Prettier formatter
  {
    "stevearc/conform.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
        },
      })
    end,
  },
}, {
  rocks = { enabled = false },
})

-- ============================================================
-- TABLINE
-- ============================================================

vim.opt.showtabline = 2

function _G.MyTabline()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    local bufnr = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
    local bufname = vim.fn.bufname(bufnr)
    local fname = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"
    local modified = vim.fn.getbufvar(bufnr, "&modified") == 1 and " +" or ""
    s = s .. (i == vim.fn.tabpagenr() and "%#TabLineSel#" or "%#TabLine#")
    s = s .. " " .. i .. " " .. fname .. modified .. " "
  end
  return s .. "%#TabLineFill#"
end

vim.opt.tabline = "%!v:lua.MyTabline()"

-- ============================================================
-- KEYMAPS
-- ============================================================

local map = function(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Insert mode pindah ke 'a' (karena 'i' dipakai navigasi)
map("n", "a",     "i",      "Insert before cursor")
map("n", "A",     "I",      "Insert beginning of line")
map("n", "<C-a>", "a",      "Append after cursor")  -- ganti append

-- IJKL navigation (normal + visual)
map({"n","v"}, "i", "k",    "Up")
map({"n","v"}, "k", "j",    "Down")
map({"n","v"}, "j", "h",    "Left")
map({"n","v"}, "l", "l",    "Right")

-- Word jump (sesuaikan dengan posisi IJKL)
map({"n","v"}, "I", "5k",   "Jump up 5 lines")
map({"n","v"}, "K", "5j",   "Jump down 5 lines")
map({"n","v"}, "J", "b",    "Word backward")
map({"n","v"}, "L", "w",    "Word forward")

-- Scroll (hindari <C-i> karena = <Tab> di terminal)
map("n", "<C-u>", "<C-u>zz", "Scroll up half page")
map("n", "<C-d>", "<C-d>zz", "Scroll down half page")

-- Kembali ke normal mode dengan double i
vim.keymap.set("i", "ii", "<Esc>", { noremap = true, silent = true })

-- Keluar terminal mode
vim.keymap.set("t", "ii", "<C-\\><C-n>", { noremap = true, silent = true })

-- Undo/redo tetap
map("n", "u",     "u",       "Undo")
map("n", "U",     "<C-r>",   "Redo")

-- File explorer
map("n", "-", "<cmd>Oil<cr>", "Open file explorer")
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", "Toggle sidebar")

-- Window navigation
map("n", "<leader>wj", "<C-w>h", "Window left")
map("n", "<leader>wl", "<C-w>l", "Window right")
map("n", "<leader>wi", "<C-w>k", "Window up")
map("n", "<leader>wk", "<C-w>j", "Window down")

-- Claude Code terminal
map("n", "<leader>ct", ":tabnew | terminal claude<CR>", "Open Claude Code terminal")

-- Tab navigation by number
for i = 1, 9 do
  map("n", "<leader>" .. i, i .. "gt", "Go to tab " .. i)
end

-- Session
map("n", "<leader>qs", function() require("persistence").load() end, "Restore session")
map("n", "<leader>ql", function() require("persistence").load({ last = true }) end, "Restore last session")
map("n", "<leader>qd", function() require("persistence").stop() end, "Stop session save")

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.css", "*.scss" },
  callback = function()
    require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
  end,
})

-- Treesitter setup (after loading)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if ok then
      configs.setup({
        ensure_installed = { "tsx", "typescript", "javascript", "css", "scss", "json", "markdown", "lua", "vim" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  end,
})
