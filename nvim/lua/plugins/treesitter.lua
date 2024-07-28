return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdateSync" },
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = {
        "html",
        "css",
        "gitcommit",
        "json",
        "json5",
        "lua",
        "markdown",
        "vim",
        "rust",
        "go",
        "elixir"
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true
      }
    }
  end
}
