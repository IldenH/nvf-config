{ pkgs, lib, ... }:
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
        file_name =
          lib.generators.mkLuaInline # lua
            ''
              function()
                local input = vim.fn.input({ prompt = "File name: " })
                return "%Y%m%dT%H%M%S" .. "-" .. input
              end
            '';
        prompt_for_file_name = false;
      };
      filetypes = {
        markdown = {
          template = "![$LABEL]($FILE_PATH)";
        };
        typst = {
          template = ''
            #figure(
              image("$FILE_PATH"),
              caption: [$CURSOR],
            ) <fig-$LABEL>
          '';
        };
      };
    };
  };
}
