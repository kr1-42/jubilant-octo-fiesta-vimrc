--------------------------------------------------------------
-- Basic Options
--------------------------------------------------------------
vim.opt.number = true
vim.opt.wrap = false
vim.opt.mouse = "a"
vim.opt.confirm = true
vim.opt.hidden = true
vim.opt.termguicolors = true
vim.opt.laststatus = 2
vim.opt.cmdheight = 1
vim.opt.showcmd = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--------------------------------------------------------------
-- lazy.nvim bootstrap
--------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------
-- Plugins
--------------------------------------------------------------
require("lazy").setup({

  -- File explorer
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },

  -- Statusline
  { "nvim-lualine/lualine.nvim" },
  {
  url = "https://codeberg.org/jthvai/lavender.nvim",
  branch = "stable", -- versioned tags + docs updates from main
  lazy = false,
  priority = 1000,
},
	{
    'tomiis4/BufferTabs.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- optional
    },
    lazy = false,
    config = function()
        require('buffertabs').setup({
            -- config
        })
    end
},
  -- Syntax & indentation
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Autocomplete
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },

})

--------------------------------------------------------------
-- Colorscheme
--------------------------------------------------------------
vim.cmd ("colorscheme lavender")
require('buffertabs').setup()
--------------------------------------------------------------
-- NvimTree Config
--------------------------------------------------------------
require("nvim-tree").setup()

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("nvim-tree.api").tree.open()
  end
})

--------------------------------------------------------------
-- Lualine Config
--------------------------------------------------------------
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

--------------------------------------------------------------
-- Treesitter Config
--------------------------------------------------------------
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
})

--------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------
vim.keymap.set("n", ";", ":")

vim.keymap.set("n", "<C-N>", ":bnext<CR>")
vim.keymap.set("n", "<C-P>", ":bprev<CR>")

vim.keymap.set("i", "$1", "()<Left>")
vim.keymap.set("i", "$2", "[]<Left>")
vim.keymap.set("i", "$3", "{}<Left>")
vim.keymap.set("i", "$4", "{<CR>}<Esc>O")
vim.keymap.set("i", "$q", "''<Left>")
vim.keymap.set("i", "$e", '""<Left>')

--------------------------------------------------------------
-- compile & run (f5)
--------------------------------------------------------------
function CompileRun()
  vim.cmd("write")

  local ft = vim.bo.filetype

  if ft == "c" then
    vim.cmd("!gcc % -o %< && time ./%<")
  elseif ft == "cpp" then
    vim.cmd("!g++ % -o %< && time ./%<")
  elseif ft == "java" then
    vim.cmd("!javac % && time java %")
  elseif ft == "sh" then
    vim.cmd("!time bash %")
  elseif ft == "python" then
    vim.cmd("!time python3 %")
  elseif ft == "html" then
    vim.cmd("!google-chrome % &")
  elseif ft == "go" then
    vim.cmd("!go build %< && time go run %")
  elseif ft == "matlab" then
    vim.cmd("!time octave %")
  end
end
vim.keymap.set("n", "<F5>", CompileRun)
vim.keymap.set("i", "<F5>", "<Esc>:lua CompileRun()<CR>")
vim.keymap.set("v", "<F5>", "<Esc>:lua CompileRun()<CR>")
--------------------------------------------------------------
-- colorscheme
--------------------------------------------------------------
-- Default config in lua
vim.g.lavender = {
  transparent = {
    background = false, -- do not render the main background
    float      = false, -- do not render the background in floating windows
    popup      = false, -- do not render the background in popup menus
    sidebar    = false, -- do not render the background in sidebars
  },
  contrast = true, -- colour the sidebar and floating windows differently to the main background

  italic = {
    comments  = true, -- italic comments
    functions = true, -- italic function names
    keywords  = false, -- italic keywords
    variables = false, -- italic variables
  },

  signs = false, -- use icon (patched font) diagnostic sign text

  -- new values will be merged in
  overrides = {
    -- highlight groups - see theme.lua
    -- existing groups will be entirely replaced
    theme = {},

    colors = {
      cterm = {}, -- cterm colours - see colors/cterm.lua
      hex = {}, -- hex (true) colours - see colors/hex.lua
    },
  },
}
