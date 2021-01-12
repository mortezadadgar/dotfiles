lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "go", "python",
  highlight = {
    enable = true,
  },
    indent = {
    enable = true
  },
}
EOF
