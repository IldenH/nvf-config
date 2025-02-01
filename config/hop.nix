{ pkgs, ... }:
{
  vim.lazy.plugins."hop.nvim" = {
    package = pkgs.vimPlugins.hop-nvim;
    setupModule = "hop";
    keys = [
      {
        mode = "n";
        key = "<leader><space>";
        desc = "Hop";
        action = "<cmd>HopChar1<cr>";
      }
    ];
    setupOpts = {
      multi_windows = true;
      keys = "asdfghjkløæqwertyuiopåzxcvbnm,.-";
    };
  };
}
