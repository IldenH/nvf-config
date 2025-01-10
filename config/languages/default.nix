{ pkgs, ... }:
{
  imports = [
    ./completion.nix
  ];

  vim = {
    languages = {
      # Options applied to all languages
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      enableDAP = true;

      # Languages
      nix = {
        enable = true;
        format = {
          type = "nixfmt";
          package = pkgs.nixfmt-rfc-style;
        };
      };
      markdown.enable = true;
      markdown.lsp.enable = false;
      ts.enable = true;
      python.enable = true;
      html.enable = true;
      css.enable = true;
      tailwind.enable = true;
      lua.enable = true;
      haskell.enable = true;
      svelte.enable = true;
      astro.enable = true;
      rust.enable = true;
    };

    lsp = {
      formatOnSave = true;
      # lspkind.enable = true;
      trouble.enable = true;
      lspSignature.enable = true;
      otter-nvim.enable = true;
    };

    debugger = {
      nvim-dap = {
        enable = true;
        ui.enable = true;
      };
    };

    treesitter = {
      enable = true;
      addDefaultGrammars = true;
      autotagHtml = true;
      # context = {
      #   enable = true;
      #   setupOpts = {
      #     max_lines = 2;
      #   };
      # };
      # Maybe just install every single one from `pkgs.tree-sitter-grammars`?
      grammars = with pkgs.tree-sitter-grammars; [
        tree-sitter-yaml # Affects obsidian note frontmatter
      ];
    };

    autopairs.nvim-autopairs.enable = true;
  };
}
