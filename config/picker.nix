{ util, ... }:
{
  vim = {
    fzf-lua = {
      enable = true;
      profile = "default-title";
    };

    keymaps = [
      (util.mkKeymap "n" "<leader>fF" ":FzfLua<cr>" " Picker")
      (util.mkKeymap "n" "<leader>ff" ":FzfLua files<cr>" " Find")
      (util.mkKeymap "n" "<leader>fs" ":FzfLua live_grep_glob<cr>" " Search")
      (util.mkKeymap "n" "<leader>fb" ":FzfLua lgrep_curbuf<cr>" " Search buffer")

      (util.mkKeymap "n" "<leader>gg" ":FzfLua git_files<cr>" " Find")
      (util.mkKeymap "n" "<leader>gc" ":FzfLua git_commits<cr>" " Commits")
      (util.mkKeymap "n" "<leader>gC" ":FzfLua git_bcommits<cr>" " Buffer commits")
      (util.mkKeymap "n" "<leader>gs" ":FzfLua git_status<cr>" "󱖫 Status")
      (util.mkKeymap "n" "<leader>gb" ":FzfLua git_blame<cr>" " Blame")
      (util.mkKeymap "n" "<leader>gB" ":FzfLua git_branches<cr>" " Branches")

      # LSP: TODO
      # Other
      (util.mkKeymap "n" "<leader>fc" ":FzfLua command_history<cr>" "Command history")
      (util.mkKeymap "n" "<leader>fC" ":FzfLua commands<cr>" "Commands")
      (util.mkKeymap "n" "<leader>fh" ":FzfLua helptags<cr>" "Vim help")
      (util.mkKeymap "n" "<leader>fH" ":FzfLua manpages<cr>" "Man pages")
      (util.mkKeymap "n" "<leader>fr" ":FzfLua registers<cr>" "Registers")
      (util.mkKeymap "n" "<leader>fp" ":FzfLua complete_path<cr>" "Path")
    ];
  };
}
