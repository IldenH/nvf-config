{ util, ... }:
{
  vim = {
    binds.whichKey = {
      enable = true;
      register = {
        "<leader>f" = "Pickers";
        "<leader>g" = "Git";
        "<leader>d" = "Debugger";
        "<leader>l" = "LSP";
      };
      setupOpts = {
        preset = "classic";
        delay = 0;
        icons = {
          mappings = false;
          separator = "➜";
          group = "";
        };
        win.border = "none";
        triggers = [
          {
            "@" = "<leader>";
            mode = "n";
          }
        ];
      };
    };

    keymaps = [
      (util.mkKeymap' "v" "<" "<gv")
      (util.mkKeymap' "v" ">" ">gv")
      (util.mkKeymap' "n" "j" "gj")
      (util.mkKeymap' "n" "k" "gk")
      (util.mkKeymap' "n" "H" "_")
      (util.mkKeymap' "n" "L" "g_")
    ];
  };
}
