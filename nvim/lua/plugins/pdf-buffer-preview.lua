return {
  {
    "propilideno/buffer-preview.nvim",
    version = "v1.2.2",
    event = "BufReadCmd *.pdf",
    dependencies = {
      {
        "3rd/image.nvim",
        lazy = true,
        build = false,
        opts = {
          backend = "ueberzug",
          processor = "magick_cli",
          integrations = {
            markdown = { enabled = false },
            asciidoc = { enabled = false },
            neorg = { enabled = false },
            rst = { enabled = false },
            typst = { enabled = false },
            html = { enabled = false },
            css = { enabled = false },
          },
        },
      },
    },
    opts = {
      rasterizer = "pdftoppm",
      dpi = 180,
    },
  },
}
