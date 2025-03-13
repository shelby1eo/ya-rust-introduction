require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- disabled since conflict with default bindings
-- map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "File Format with conform" })

-- disabled since not usefull
-- map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- custum keymapping
map("n", "c", "\"_c", { desc = "avoid c to modify clipboard" })
map("n", "C", "\"_C", { desc = "avoid c to modify clipboard" })

-- dap key mappings
-- Nvim DAP
-- https://github.com/letsgetrusty/neovim-rust/blob/main/lua/mappings.lua
-- https://github.com/mfussenegger/nvim-dap/blob/9adbfdca13afbe646d09a8d7a86d5d031fb9c5a5/doc/dap.txt#L316
-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
  "n",
  "<Leader>dd",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })

-- Nvim DAP-ui
-- ToDo: map open scope, watch views
map({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, { desc = "dap-ui hover" })
map({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end, { desc = "dap-ui preview" })
map('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
end, { desc = "dap-ui frames call-stack" })
map('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, { desc = "dap-ui scope" })

-- lsp
local bufnr = vim.api.nvim_get_current_buf()
-- supports rust-analyzer's grouping
map("n", "<leader>la", function()  vim.cmd.RustLsp('codeAction') end, { desc = "rustLsp codeAction", silent = true, buffer = bufnr })
-- if you don't want grouping.
-- map("n", "<leader>a", function() vim.lsp.buf.codeAction() end, { silent = true, buffer = bufnr })

-- Displays hover information about the symbol under the cursor
map('n', '<Leader>lk', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = "hover", buffer = true })
-- Jump to the definition
map('n', '<Leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = "j-def", buffer = true })
-- Jump to declaration
map('n', '<Leader>lD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = "j-dec", buffer = true })
-- Lists all the implementations for the symbol under the cursor
map('n', '<Leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = "list-impl", buffer = true })
-- Jumps to the definition of the type symbol
map('n', '<Leader>lo', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = "j-def-type-symb", buffer = true })
-- Lists all the references 
map('n', '<Leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = "list-ref", buffer = true })
-- Displays a function's signature information
map('n', '<Leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = "func-sig-info", buffer = true })
-- Renames all references to the symbol under the cursor
map('n', '<Leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = "rename", buffer = true })
-- Selects a code action available at the current cursor position
map('n', '<Leader>A', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = "action", buffer = true })
-- Show diagnostics in a floating window
map('n', '<Leader>ll', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = "diag", buffer = true })
-- Move to the previous diagnostic
map('n', '<Leader>l[', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = "diag-prev", buffer = true })
-- Move to the next diagnostic
map('n', '<Leader>l]', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = "diag-next", buffer = true })

-- scrolling bindings
-- complete cmp.nvim key mapping
-- c-f: scroll forward
-- c-d: scrool back
-- c-space: auto complete

-- https://github.com/prabirshrestha/vim-lsp/issues/1161
-- Nvim also maps K to vim.lsp.buf.hover() in Normal mode.

-- lsp key mapping
-- Configure Linting, Formatting, and Autocompletion in Neovim
-- https://www.youtube.com/watch?v=lpQMeFph1RE
-- https://www.youtube.com/watch?v=y1WWOaLCNyI
-- https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/
    -- Trigger code completion
    -- bufmap('i', '<C-Space>', '<C-x><C-o>')

    -- Display documentation of the symbol under the cursor
    -- bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    -- bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    -- bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    -- bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    -- bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    -- bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    -- bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    -- bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Format current file
    -- bufmap('n', '<F3>', '<cmd>lua vim.lsp.buf.format()<cr>')

    -- Selects a code action available at the current cursor position
    -- bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

-- Vimspector keys mapping
-- " mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)
-- " for normal mode - the word under the cursor
-- nmap <Leader>di <Plug>VimspectorBalloonEval
-- map("n", "ff", "<Plug>VimspectorBalloonEval", { desc = "VimspectorBalloonEval in normal mode" })
-- " for visual mode, the visually selected text
-- xmap <Leader>di <Plug>VimspectorBalloonEval

-- extra useful mappings
-- nmap <LocalLeader><F11> <Plug>VimspectorUpFrame
-- nmap <LocalLeader><F12> <Plug>VimspectorDownFrame
-- nmap <LocalLeader>B     <Plug>VimspectorBreakpoints
-- nmap <LocalLeader>D     <Plug>VimspectorDisassemble

-- debug mapping
-- F5
-- map("n", "<F7>", "<Plug>VimspectorContinue", { desc = "When debugging, continue. Otherwise start debugging." })
-- F3
-- map("n", "<F8>", "<Plug>VimspectorStop", { desc = "Stop debugging." })
-- F4
-- map("n", "<F9>", "<Plug>VimspectorRestart", { desc = "Restart debugging with the same configuration." })
-- F6
-- map("n", "ff", "<Plug>VimspectorPause", { desc = "Pause debuggee." })
-- F9
-- map("n", "<F5>", "<Plug>VimspectorToggleBreakpoint", { desc = "Toggle line breakpoint on the current line." })
-- <leader>F9
-- map("n", "<F7>", "<Plug>VimspectorToggleConditionalBreakpoint", { desc = "Toggle conditional line breakpoint or logpoint on the current line." })
-- F8
-- map("n", "<F6>", "<Plug>VimspectorAddFunctionBreakpoint", { desc = "Add a function breakpoint for the expression under cursor" })
-- <leader>F8
-- map("n", "ff", "<Plug>VimspectorRunToCursor", { desc = "Run to Cursor" })
-- F10
-- map("n", "<F2>", "<Plug>VimspectorStepOver", { desc = "Step Over" })
-- F11
-- map("n", "<F3>", "<Plug>VimspectorStepInto", { desc = "Step Into" })
-- F12
-- map("n", "<F4>", "<Plug>VimspectorStepOut", { desc = "Step out of current function scope" })
--
--
