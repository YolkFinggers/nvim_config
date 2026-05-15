return {
  -- Autocompletion
  {
    'saghen/blink.cmp',
    version = '1.*',
    event = 'VimEnter',

    dependencies = {
      -- Blink core dependency
      'saghen/blink.lib',

      -- Compatibility layer for cmp sources
      {
        'saghen/blink.compat',
        version = '*',
        lazy = true,
      },

      -- Laravel completion source
      {
        'ribru17/blink-cmp-spell',
      },

      -- LuaSnip
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Regex support for snippets
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end

          return 'make install_jsregexp'
        end)(),

        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },

        opts = {},
      },

      -- Better Lua completion for Neovim config
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {},
      },
    },

    build = function()
      require('blink.cmp').build()
    end,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },

        menu = {
          border = 'rounded',
        },

        documentation = {
          window = {
            border = 'rounded',
          },
        },
      },

      snippets = {
        preset = 'luasnip',
      },

      signature = {
        enabled = true,
        window = {
          border = 'rounded',
        },
      },

      fuzzy = {
        implementation = 'prefer_rust_with_warning',
      },

      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
          'spell',
        },

        providers = {
          spell = {
            name = 'Spell',
            module = 'blink-cmp-spell',
            score_offset = -5,
          },
        },
      },

      cmdline = {
        enabled = false,
      },
    },

    opts_extend = {
      'sources.default',
    },
  },
}
