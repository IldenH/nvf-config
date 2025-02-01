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
      indent-blankline = {
        enable = true;
        setupOpts = {
          indent = {
            char = "▍";
            smart_indent_cap = true;
          };
          scope = {
            enabled = true;
            show_start = false;
            show_end = false;
          };
        };
      };
      rainbow-delimiters.enable = true;
    };

    highlight = {
      SignColumn.bg = colorScheme'.base00;
    };
  };
}
