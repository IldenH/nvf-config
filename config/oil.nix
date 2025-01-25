{ pkgs, lib, ... }:
{
  vim.lazy.plugins."oil.nvim" = {
    package = pkgs.vimPlugins.oil-nvim;
    setupModule = "oil";
    keys = [
      {
        mode = "n";
        key = "<leader>fe";
        desc = "󱇨 Edit";
        action = "<cmd>Oil<cr>";
      }
    ];
    setupOpts = {
      view_options = {
        show_hidden = true;
        is_always_hidden =
          lib.generators.mkLuaInline # lua
            ''
              function(name)
                if name == ".git" or name == ".direnv" then
                  return true
                end
              end
            '';
      };
    };
  };
}
