{ lib, colorScheme', ... }:
{
  vim = {
    theme = {
      enable = true;
      # Looks bad :(
      # name = "base16";
      # base16-colors = colorScheme.palette;
      name = "gruvbox";
      style = "dark";
    };

    visuals = {
      nvim-web-devicons.enable = true;
      rainbow-delimiters.enable = true;
    };

    luaConfigRC.highlights = lib.nvim.dag.entryAnywhere ''
      vim.api.nvim_set_hl(0, "SignColumn", {bg = "${colorScheme'.base00}"})
    '';
  };
}
