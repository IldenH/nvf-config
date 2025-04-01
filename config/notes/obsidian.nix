{
  lib,
  util,
  colorScheme',
  ...
}:
let
  vault_path = "dev/Vault";
in
{
  vim = {
    notes.obsidian = {
      enable = true;
      setupOpts = {
        log_level = lib.generators.mkLuaInline "vim.log.levels.ERROR";

        workspaces = [
          {
            name = "Vault";
            path = "~/${vault_path}";
          }
        ];
        notes_subdir = "notes";
        attachments.img_folder = "assets";
        daily_notes = {
          folder = "daily";
          date_format = "%Y-%m-%d";
        };

        completion.min_chars = 0;
        picker = {
          name = "fzf-lua";
          mappings.new = "<C-x>";
          mappings.insert_link = "<C-l>";
          tag_mappings.tag_note = "<C-x>";
          tag_mappings.insert_tag = "<C-l>";
        };

        preferred_link_style = "markdown";

        note_id_func =
          lib.generators.mkLuaInline # lua
            ''
              function(title)
                if title == nil or title == "" then
                  error("Title cannot be empty")
                end

                local name = title:gsub(" ", "-"):lower():gsub("[^a-z0-9-æøå]", "")
                return name
              end
            '';

        follow_url_func =
          lib.generators.mkLuaInline # lua
            ''
              function(url)
                vim.fn.jobstart({"wl-copy", url})
                vim.fn.jobstart({"notify-send", "Copied " .. url .. " to clipboard."})
              end
            '';

        follow_img_func =
          lib.generators.mkLuaInline # lua
            ''
              function(url)
                vim.ui.open(url)
              end
            '';

        attachments = {
          img_name_func =
            lib.generators.mkLuaInline # lua
              ''
                function()
                  return tostring(os.date("%Y%m%dT%H%M")) .. "-"
                end
              '';
        };

        ui.hl_groups = with colorScheme'; {
          ObsidianTodo.fg = base0A;
          ObsidianDone.fg = base0B;
          ObsidianRightArrow.fg = base09;
          # ObsidianTilde.fg = base0F;
          # ObsidianImportant.fg = base08;
          ObsidianBullet.fg = base0D;
          ObsidianRefText.fg = base0E;
          ObsidianExtLinkIcon.fg = base0E;
          ObsidianTag.fg = base0C;
          ObsidianBlockID.fg = base0C;
          ObsidianHighlightText.bg = base0A;
          ObsidianHighlightText.fg = base01;
        };
      };
    };

    highlight =
      with colorScheme';
      lib.mapAttrs' (name: value: lib.nameValuePair "@markup.heading.${name}.markdown" { fg = value; }) {
        "1" = base08;
        "2" = base0A;
        "3" = base0B;
        "4" = base0C;
        "5" = base0D;
        "6" = base0E;
      };

    keymaps = [
      (util.mkKeymap "n" "<leader>on" "<cmd>ObsidianNew<cr>" " New note")
      (util.mkKeymap "n" "<leader>op" "<cmd>ObsidianOpen<cr>" " Open")
      (util.mkKeymap "n" "<leader>or" "<cmd>ObsidianRename<cr>" "󱇨 Rename")
      (util.mkKeymap "x" "<leader>oe" "<cmd>ObsidianExtractNote<cr>" "󰩭 Extract note")
      (util.mkKeymap "n" "<leader>ob" "<cmd>ObsidianBacklinks<cr>" " Backlinks")
      (util.mkKeymap "n" "<leader>of" "<cmd>ObsidianQuickSwitch<cr>" " Find")
      (util.mkKeymap "n" "<leader>os" "<cmd>ObsidianSearch<cr>" " Search")
      (util.mkKeymap "n" "<leader>od" "<cmd>ObsidianDailies<cr>" " Dailies")
      (util.mkKeymap "n" "<leader>ot" "<cmd>ObsidianToday<cr>" " Today")
      (util.mkKeymap "n" "<leader>oi" "<cmd>ObsidianPasteImg<cr>" " Paste img")
      (util.mkKeymap "n" "<leader>oa" "<cmd>ObsidianTags<cr>" " Tags")
    ];
  };
}
