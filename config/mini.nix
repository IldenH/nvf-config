{
  util,
  lib,
  colorScheme',
  ...
}:
{
  vim = {
    mini = {
      icons.enable = true;
      statusline.enable = true;
      tabline.enable = true;
      git.enable = true;
      diff.enable = true;
      align.enable = true;
      files.enable = true;
      operators.enable = true;
      trailspace.enable = true;
      jump2d = {
        enable = true;
        setupOpts = {
          labels = "asdfghjklqwertyuiopzxcvbnm";
          mappings.start_jumping = "<leader><space>";
          view.dim = true;
          silent = true;
        };
      };
      hipatterns = {
        enable = true;
        setupOpts.highlighters =
          let
            mkPattern = pattern: "%f[%w]()${pattern}()%f[%W]";
            mkHi = pattern: group: {
              inherit group;
              pattern = mkPattern pattern;
            };
          in
          {
            todo = mkHi "TODO" "MiniHipatternsTodo";
            hack = mkHi "HACK" "MiniHipatternsHack";
            note = mkHi "NOTE" "MiniHipatternsNote";
            fixme = mkHi "FIXME" "MiniHipatternsFixme";

            headline1 = {
              pattern = "^# .*";
              group = "Headline1";
            };
            headline2 = {
              pattern = "^## .*";
              group = "Headline2";
            };
            headline3 = {
              pattern = "^### .*";
              group = "Headline3";
            };
            headline4 = {
              pattern = "^#### .*";
              group = "Headline4";
            };
            headline5 = {
              pattern = "^##### .*";
              group = "Headline5";
            };
            headline6 = {
              pattern = "^###### .*";
              group = "Headline6";
            };

            hex_color = lib.generators.mkLuaInline ''require("mini.hipatterns").gen_highlighter.hex_color()'';
            base16_color =
              lib.generators.mkLuaInline # lua

                ''
                  {
                    pattern = "base0[%dA-F]",
                    group = function(_, match)
                      local words = ${lib.nvim.lua.toLuaObject colorScheme'}
                      local hex = words[match]
                      if hex == nil then return nil end
                      return MiniHipatterns.compute_hex_color_group(hex, bg)
                    end,
                  }
                '';
          };
      };
      comment.enable = true;
      move.enable = true;
      pairs.enable = true;
      splitjoin.enable = true;
      bracketed.enable = true;
    };

    luaConfigPost = with colorScheme'; ''
      vim.api.nvim_set_hl(0, "Headline1", { fg = "${base08}" })
      vim.api.nvim_set_hl(0, "Headline2", { fg = "${base0A}" })
      vim.api.nvim_set_hl(0, "Headline3", { fg = "${base0B}" })
      vim.api.nvim_set_hl(0, "Headline4", { fg = "${base0C}" })
      vim.api.nvim_set_hl(0, "Headline5", { fg = "${base0D}" })
      vim.api.nvim_set_hl(0, "Headline6", { fg = "${base0E}" })
    '';
    keymaps = [
      (util.mkKeymap' "n" "<tab>" ":bn<cr>")
      (util.mkKeymap' "n" "<S-tab>" ":bp<cr>")
      (util.mkKeymap' "n" "<C-c>" ":bd<cr>")
      (util.mkKeymap "n" "<leader>fm" ":lua MiniFiles.open()<cr>" "Open mini.files")
    ];
  };
}
