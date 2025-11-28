--------------------------------------------------------------
-- Basic Options
--------------------------------------------------------------
vim.opt.backup        = false
vim.opt.cmdheight     = 1
vim.opt.confirm       = true
vim.opt.hidden        = true
vim.opt.laststatus    = 2
vim.opt.mouse         = "a"
vim.opt.number        = true
vim.opt.showcmd       = true
vim.opt.swapfile      = false
vim.opt.termguicolors = true
vim.opt.wrap          = false
vim.opt.writebackup   = false

-- Disable netrw (recommended for nvim-tree or other tree plugins)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


--------------------------------------------------------------
-- lazy.nvim bootstrap
--------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)


--------------------------------------------------------------
-- Plugins
--------------------------------------------------------------
require("lazy").setup({

  -- Statusline
  { "nvim-lualine/lualine.nvim" },

  -- Colorscheme
   {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
  },
  { "savq/melange-nvim" },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },

  -- Bufferline
 {
    'tomiis4/BufferTabs.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- optional
    },
},
  -- Syntax & indentation
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Autocomplete
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },

  -- highlight word
    {
        "sontungexpt/stcursorword",
        event = "VeryLazy",
        config = true,
    },
	--termintergration
    {
  "luxvim/nvim-luxterm"
      },
    {
  "nvim-tree/nvim-tree.lua"
    },
})


--------------------------------------------------------------
-- Colorscheme activation
--------------------------------------------------------------
vim.cmd("colorscheme nord")
--------------------------------------------------------------
-- Lualine Config
--------------------------------------------------------------
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "nord",
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    always_divide_middle = true,
    always_show_tabline  = true,
    globalstatus = false,

    refresh = {
      statusline = 1000,
      tabline   = 1000,
      winbar    = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        "WinEnter", "BufEnter", "BufWritePost",
        "SessionLoadPost", "FileChangedShellPost",
        "VimResized", "Filetype", "CursorMoved",
        "CursorMovedI", "ModeChanged",
      },
    },
  },

  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },

  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})


require("nvim-tree").setup()
--------------------------------------------------------------
-- Treesitter Config
--------------------------------------------------------------
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent    = { enable = true },
})


--------------------------------------------------------------
-- Barbar (bufferline) Keymaps
--------------------------------------------------------------

require('buffertabs').setup()

--------------------------------------------------------------
-- General Keymaps
--------------------------------------------------------------
vim.g.mapleader = " "

vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-S>", "<C-B>zz")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<C-N>", ":bnext<CR>")
vim.keymap.set("n", "<C-P>", ":bprev<CR>")
vim.keymap.set("n", "<leader>tn", ":LuxtermNew<CR>", { desc = "New terminal" })
vim.keymap.set("n", "<leader>t", ":LuxtermToggle<CR>", { desc = "New terminal" })

-- Auto-pairs
vim.keymap.set("i", "$2", "()<Left>")
vim.keymap.set("i", "$3", "[]<Left>")
vim.keymap.set("i", "$4", "{}<Left>")
vim.keymap.set("i", "$1", "{<CR>}<Esc>O")
vim.keymap.set("i", "$q", "''<Left>")
vim.keymap.set("i", "$e", '""<Left>')


--------------------------------------------------------------
-- Compile & Run (F5)
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
-- nord Theme Settings
--------------------------------------------------------------
require("nord").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
  borders = true, -- Enable the border between verticaly split windows visible
  errors = { mode = "bg" }, -- Display mode for errors and diagnostics
                            -- values : [bg|fg|none]
  search = { theme = "vim" }, -- theme for highlighting search results
                              -- values : [vim|vscode]
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = {},
    functions = {},
    variables = {},

    -- To customize lualine/bufferline
    bufferline = {
      current = {},
      modified = { italic = true },
    },

    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
  },

  -- colorblind mode
  -- see https://github.com/EdenEast/nightfox.nvim#colorblind
  -- simulation mode has not been implemented yet.
  colorblind = {
    enable = false,
    preserve_background = false,
    severity = {
      protan = 0.0,
      deutan = 0.0,
      tritan = 0.0,
    },
  },

  -- Override the default colors
  ---@param colors Nord.Palette
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with all highlights and the colorScheme table
  ---@param colors Nord.Palette
  on_highlights = function(highlights, colors) end,
})
--------------------------------------------------------------
-- Cyberdream Theme Settings
--------------------------------------------------------------
require("cyberdream").setup({
  variant = "default",
  transparent = true,
  saturation = 1,
  italic_comments = false,
  hide_fillchars = false,
  borderless_pickers = true,
  terminal_colors = true,
  cache = false,

  highlights = {
    Comment = { fg = "#696969", bg = "NONE", italic = true },
  },

  overrides = function(colors)
    return {
      Comment       = { fg = colors.green, bg = "NONE", italic = true },
      ["@property"] = { fg = colors.magenta, bold = true },
    }
  end,

  colors = {
    bg    = "#000000",
    green = "#00ff00",

    dark = {
      magenta = "#ff00ff",
      fg      = "#eeeeee",
    },
    light = {
      red  = "#ff5c57",
      cyan = "#5ef1ff",
    },
  },

  extensions = {
    telescope = true,
    notify = true,
    mini = true,
  },
})
--------------------------------------------------------------
-- highlight words
--------------------------------------------------------------
    -- default configuration
    require("stcursorword").setup({
        max_word_length = 100, -- if cursorword length > max_word_length then not highlight
        min_word_length = 2, -- if cursorword length < min_word_length then not highlight
        excluded = {
            filetypes = {
                "TelescopePrompt",
            },
            buftypes = {
                -- "nofile",
                -- "terminal",
            },
            patterns = { -- the pattern to match with the file path
                -- "%.png$",
                -- "%.jpg$",
                -- "%.jpeg$",
                -- "%.pdf$",
                -- "%.zip$",
                -- "%.tar$",
                -- "%.tar%.gz$",
                -- "%.tar%.xz$",
                -- "%.tar%.bz2$",
                -- "%.rar$",
                -- "%.7z$",
                -- "%.mp3$",
                -- "%.mp4$",
            },
        },
        highlight = {
            underline = true,
            fg = nil,
            bg = nil,
        },
    })
--------------------------------------------------------------
-- Web Devicons
--------------------------------------------------------------
require("nvim-web-devicons").setup({
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh",
    },
  },

  color_icons = true,
  default = true,
  strict = true,
  variant = "light|dark",
  blend = 0,

  override_by_filename = {
    [".gitignore"] = {
      icon = "",
      color = "#f1502f",
      name = "Gitignore",
    },
  },

  override_by_extension = {
    ["log"] = {
      icon = "",
      color = "#81e043",
      name = "Log",
    },
  },

  override_by_operating_system = {
    ["apple"] = {
      icon = "",
      color = "#A2AAAD",
      cterm_color = "248",
      name = "Apple",
    },
  },
})
--------------------------------------------------------------
-- termintegration
--------------------------------------------------------------
require("luxterm.config").apply_preset("compact")
