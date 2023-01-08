return {
  "b0o/SchemaStore.nvim",
  "nvim-lua/plenary.nvim",
  { "folke/lazy.nvim", version = "^9" },
  { "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } },
  {
    "folke/neodev.nvim",
    version = "^1",
    opts = { library = { plugins = false }, lspconfig = false },
    default_config = function(opts) require("neodev").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      ignored_filetypes = {
        "nofile",
        "quickfix",
        "qf",
        "prompt",
      },
      ignored_buftypes = { "nofile" },
    },
    default_config = function(opts) require("smart-splits").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "onsails/lspkind.nvim",
    opts = {
      mode = "symbol",
      symbol_map = {
        NONE = "",
        Array = "",
        Boolean = "⊨",
        Class = "",
        Constructor = "",
        Key = "",
        Namespace = "",
        Null = "NULL",
        Number = "#",
        Object = "⦿",
        Package = "",
        Property = "",
        Reference = "",
        Snippet = "",
        String = "𝓐",
        TypeParameter = "",
        Unit = "",
      },
    },
    enabled = vim.g.icons_enabled,
    default_config = function(opts)
      astronvim.lspkind = opts
      require("lspkind").init(opts)
    end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "^1",
    opts = function() return { use_winbar = "smart", other_win_hl_color = require("astronvim.colors").grey_4 } end,
    default_config = function(opts) require("window-picker").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = { java = false },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
    default_config = function(opts)
      local npairs = require "nvim-autopairs"
      npairs.setup(opts)

      if not vim.g.autopairs_enabled then npairs.disable() end
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done { tex = false })
      end
    end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "folke/which-key.nvim",
    version = "^1",
    event = "VeryLazy",
    opts = {
      plugins = {
        spelling = { enabled = true },
        presets = { operators = false },
      },
      window = {
        border = "rounded",
        padding = { 2, 2, 2, 2 },
      },
      disable = { filetypes = { "TelescopePrompt" } },
    },
    default_config = function(opts) require("which-key").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "numToStr/Comment.nvim",
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    opts = function()
      local utils = require "Comment.utils"
      return {
        pre_hook = function(ctx)
          local location = nil
          if ctx.ctype == utils.ctype.blockwise then
            location = require("ts_context_commentstring.utils").get_cursor_location()
          elseif ctx.cmotion == utils.cmotion.v or ctx.cmotion == utils.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
          end

          return require("ts_context_commentstring.internal").calculate_commentstring {
            key = ctx.ctype == utils.ctype.linewise and "__default" or "__multiline",
            location = location,
          }
        end,
      }
    end,
    default_config = function(opts) require("Comment").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
      size = 10,
      open_mapping = [[<F7>]],
      shading_factor = 2,
      direction = "float",
      float_opts = {
        border = "curved",
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    default_config = function(opts) require("toggleterm").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    enabled = vim.g.icons_enabled,
    opts = {
      deb = { icon = "", name = "Deb" },
      lock = { icon = "", name = "Lock" },
      mp3 = { icon = "", name = "Mp3" },
      mp4 = { icon = "", name = "Mp4" },
      out = { icon = "", name = "Out" },
      ["robots.txt"] = { icon = "ﮧ", name = "Robots" },
      ttf = { icon = "", name = "TrueTypeFont" },
      rpm = { icon = "", name = "Rpm" },
      woff = { icon = "", name = "WebOpenFontFormat" },
      woff2 = { icon = "", name = "WebOpenFontFormat2" },
      xz = { icon = "", name = "Xz" },
      zip = { icon = "", name = "Zip" },
    },
    default_config = function(opts)
      require("nvim-web-devicons").set_default_icon(astronvim.get_icon "DefaultFile", "#6d8086", "66")
      require("nvim-web-devicons").set_icon(opts)
    end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "Darazaki/indent-o-matic",
    init = function() table.insert(astronvim.file_plugins, "indent-o-matic") end,
    opts = {},
    default_config = function(opts)
      local indent_o_matic = require "indent-o-matic"
      indent_o_matic.setup(opts)
      indent_o_matic.detect()
    end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "rcarriga/nvim-notify",
    version = "^3",
    init = function() astronvim.load_plugin_with_func("nvim-notify", vim, "notify") end,
    opts = { stages = "fade" },
    default_config = function(opts)
      local notify = require "notify"
      notify.setup(opts)
      vim.notify = notify
    end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "stevearc/dressing.nvim",
    init = function() astronvim.load_plugin_with_func("dressing.nvim", vim.ui, { "input", "select" }) end,
    opts = {
      input = {
        default_prompt = "➤ ",
        win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
      },
      select = {
        backend = { "telescope", "builtin" },
        builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
      },
    },
    default_config = function(opts) require("dressing").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    init = function() table.insert(astronvim.file_plugins, "nvim-colorizer.lua") end,
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    opts = { user_default_options = { names = false } },
    default_config = function(opts) require("colorizer").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    opts = {},
    default_config = function(opts) require("better_escape").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "Shatur/neovim-session-manager",
    event = "BufWritePost",
    cmd = "SessionManager",
    opts = {},
    default_config = function(opts) require("session_manager").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    init = function() table.insert(astronvim.file_plugins, "indent-blankline.nvim") end,
    opts = {
      buftype_exclude = {
        "nofile",
        "terminal",
      },
      filetype_exclude = {
        "help",
        "startify",
        "aerial",
        "alpha",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "neo-tree",
        "Trouble",
      },
      context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "operation_type",
      },
      show_trailing_blankline_indent = false,
      use_treesitter = true,
      char = "▏",
      context_char = "▏",
      show_current_context = true,
    },
    default_config = function(opts) require("indent_blankline").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = vim.fn.executable "git" == 1,
    ft = "gitcommit",
    init = function() table.insert(astronvim.git_plugins, "gitsigns.nvim") end,
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
    default_config = function(opts) require("gitsigns").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    opts = function()
      local actions = require "telescope.actions"
      return {
        defaults = {

          prompt_prefix = string.format("%s ", astronvim.get_icon "Search"),
          selection_caret = string.format("%s ", astronvim.get_icon "Selected"),
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },

          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = { ["q"] = actions.close },
          },
        },
      }
    end,
    default_config = function(opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      astronvim.conditional_func(telescope.load_extension, pcall(require, "notify"), "notify")
      astronvim.conditional_func(telescope.load_extension, pcall(require, "aerial"), "aerial")
      astronvim.conditional_func(telescope.load_extension, astronvim.is_available "telescope-fzf-native.nvim", "fzf")
    end,
    config = function(plugin, opts) plugin.default_config(opts) end,
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
    },
  },
  {
    "stevearc/aerial.nvim",
    init = function() table.insert(astronvim.file_plugins, "aerial.nvim") end,
    opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = {
        min_width = 28,
      },
      show_guides = true,
      filter_kind = false,
      guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
      },
      keymaps = {
        ["[y"] = "actions.prev",
        ["]y"] = "actions.next",
        ["[Y"] = "actions.prev_up",
        ["]Y"] = "actions.next_up",
        ["{"] = false,
        ["}"] = false,
        ["[["] = false,
        ["]]"] = false,
      },
    },
    default_config = function(opts) require("aerial").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "neovim/nvim-lspconfig",
    init = function() table.insert(astronvim.file_plugins, "nvim-lspconfig") end,
    default_config = function(_)
      if vim.g.lsp_handlers_enabled then
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
        vim.lsp.handlers["textDocument/signatureHelp"] =
          vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
      end
      local setup_servers = function()
        vim.tbl_map(astronvim.lsp.setup, astronvim.user_plugin_opts "lsp.servers")
        vim.api.nvim_exec_autocmds("FileType", {})
      end
      if astronvim.is_available "mason-lspconfig.nvim" then
        vim.api.nvim_create_autocmd("User", { pattern = "AstroLspSetup", once = true, callback = setup_servers })
      else
        setup_servers()
      end
    end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    init = function() table.insert(astronvim.file_plugins, "null-ls.nvim") end,
    opts = { on_attach = astronvim.lsp.on_attach },
    default_config = function(opts) require("null-ls").setup(opts) end,
    config = function(plugin, opts) plugin.default_config(opts) end,
  },
  {
    "mfussenegger/nvim-dap",
    enabled = vim.fn.has "win32" == 0,
    init = function() table.insert(astronvim.file_plugins, "nvim-dap") end,
    default_config = function(_)
      local dap = require "dap"
      dap.adapters = astronvim.user_plugin_opts("dap.adapters", dap.adapters)
      dap.configurations = astronvim.user_plugin_opts("dap.configurations", dap.configurations)
    end,
    config = function(plugin, opts) plugin.default_config(opts) end,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        opts = { floating = { border = "rounded" } },
        default_config = function(opts)
          local dap, dapui = require "dap", require "dapui"
          dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
          dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
          dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
          dapui.setup(opts)
        end,
        config = function(plugin, opts) plugin.default_config(opts) end,
      },
    },
  },
}
