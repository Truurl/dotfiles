return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  { "rebelot/kanagawa.nvim" },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
      style = "moon",
    },
  },
}
