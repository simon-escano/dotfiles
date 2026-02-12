return {
  -- Configure the default theme (Tokyo Night)
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,         -- This enables the transparency
      styles = {
        sidebars = "transparent", -- Make the file explorer transparent
        floats = "transparent",   -- Make floating windows transparent
      },
    },
  },
}
