local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang_format" },
    cpp = { "clang_format" },
  },
}

require("conform").setup(options)
