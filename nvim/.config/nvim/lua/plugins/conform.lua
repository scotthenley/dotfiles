return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      go = { "goimports" },
      terraform = { "terraform_fmt" },
    },
  },
}
