return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      hidden = true, -- for hidden files
      -- ignored = true,  -- for files in .gitignore
      sources = {
          files = {
            hidden = true, -- files and folders
          -- ignored = true, -- files and folders
        },
      },
    },
  },
}
