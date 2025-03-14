
-- how to read file from lua: https://www.gammon.com.au/scripts/doc.php?lua=io.open
-- :source % : source current file
-- :messages : show logs
local fd_os_release = assert(io.open("/etc/os-release"), "r")
local s_os_release = fd_os_release:read("*a")
fd_os_release:close()
s_os_release = s_os_release:lower()
local is_nixos = s_os_release:match("nixos")

-- disable installation of dependency because nixos dont use the same lib path standard
-- nix-ld solution since it gives priority to the rpath, it could breadk the system
-- https://github.com/Mic92/nix-ld
-- lsp need to be installed in the nix config
-- local l_ensure_installed = {}
-- if is_nixos == nil then
--   print("is not nixos")
-- this list need to be sync with lua/configs/lspconfig.lua
local l_ensure_installed = {
    "lua-language-server",
    "stylua",
    -- "prettier", -- ToDo: prettierd is available in nixos, ToDo check how to use this
    "marksman",
    -- "bash-language-server",
    -- "clangd",
    -- "clang-format",
    "codelldb",
  }
-- end

local plugins = {
  -- inteligent code highlight
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        -- "css",
        -- "hcl",
        "ini",
        "lua",
        "make",
        "markdown_inline",
        -- "nix",
        "python",
        "rust",
        "vim",
      },
    },
  },

  -- mason installs executables needed by lspconfig
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "marksman",
        "codelldb",
      },
    },
  },

  -- In order to modify the `lspconfig` configuration:
  {
  "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
   end,
  },

  -- inteligent code highlight
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- live grep also dotfiles
          "-g", "!.git/", -- ignore .git/
          "--ignore-case"
        },
        file_ignore_patterns = { ".git/" },
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true, -- false == consider .gitignore .ignore
                            -- true  == show all files
          follow = true, -- find also symlinks
        },
      },
    },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function ()
      local codelldb_path = ""
      local liblldb_path = ""
      if is_nixos == nil then
        local mason_registry = require('mason-registry')
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        codelldb_path = extension_path .. "adapter/codelldb"
        liblldb_path = extension_path.. "lldb/lib/liblldb.dylib"
      else
        -- Update this path
        local extension_path = vim.env.HOME .. '/.vscode-oss/extensions/vadimcn.vscode-lldb/'
        codelldb_path = extension_path .. 'adapter/codelldb'
        liblldb_path = extension_path .. 'lldb/lib/liblldb'
        -- The liblldb extension is .so for Linux and .dylib for MacOS
        local this_os = vim.uv.os_uname().sysname;
        liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
      end
      -- :checkhealth rustaceanvim
      local cfg = require('rustaceanvim.config')

      vim.g.rustaceanvim = {
        -- default_settings = {
        --   -- rust-analyzer language server configuration
        --   ['rust-analyzer'] = {
        --     cargo = {
        --       allFeatures = true
        --     },
        --   },
        -- },
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end
  },

  {
    -- if ever want to use *dap-launch.json* maybe for remote debug? or attach to process
    -- https://github.com/mfussenegger/nvim-dap/blob/9adbfdca13afbe646d09a8d7a86d5d031fb9c5a5/doc/dap.txt#L316
    'mfussenegger/nvim-dap',
    config = function()
    local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      require("dapui").setup()
    end,
  },

  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
    end
  },

  -- debugger with dissasembly
  -- {
    -- 'puremourning/vimspector',
    -- lazy = false,
  -- },

  -- ToDo: figureout how to integrate this
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function() vim.fn["mkdp#util#install"]() end,
  -- },
}
return plugins
