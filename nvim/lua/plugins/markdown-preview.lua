return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "markdown.mdx" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    keys = {
      {
        "<leader>um",
        function()
          require("render-markdown").toggle()
        end,
        ft = { "markdown", "markdown.mdx" },
        desc = "Toggle Markdown Preview",
      },
    },
    opts = {
      preset = "lazy",
      file_types = { "markdown", "markdown.mdx" },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
      },
      completions = {
        lsp = { enabled = true },
      },
    },
  },
}
