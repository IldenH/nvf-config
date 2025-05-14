{ pkgs, ... }:
{
  vim.lazy.plugins."img-clip.nvim" = {
    package = pkgs.vimPlugins.img-clip-nvim;
    setupModule = "img-clip";
    keys = [
      {
        mode = "n";
        key = "<leader>p";
        desc = "Paste image";
        action = "<cmd>PasteImage<cr>";
      }
    ];
    setupOpts = {
      default = {
        file_name = "%Y%m%dT%H%M";
      };
      filetypes = {
        markdown = {
          template = "![$LABEL]($FILE_PATH)";
        };
        typst = {
          template = "
#figure(
  image(\"$FILE_PATH\"),
  caption: [$CURSOR],
) <fig-$LABEL>
";
        };
      };
    };
  };
}
