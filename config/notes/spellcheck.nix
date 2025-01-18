{ util, lib, ... }:
let
  # .spell is synced with syncthing
  mkSpellFile = lang: "/.spell/spell/${lib.lists.head (lib.strings.splitString "_" lang)}.utf-8.add";
  mkSpell =
    langs:
    let
      langs' = lib.nvim.lua.listToLuaTable langs;
      spellfiles = map mkSpellFile langs;
      spellfiles' = lib.nvim.lua.listToLuaTable spellfiles;
    in
    # Spell is disabled by default, enabled on language switch
    ''
      function()
        vim.opt.spell = true
        vim.opt.spelllang = ${langs'}
        vim.opt.spellfile = vim.tbl_map(function (path)
          return os.getenv("HOME") .. path
        end, ${spellfiles'})
      end
    '';
in
{
  vim = {
    keymaps = [
      (util.mkLuaKeymap "n" "<leader>cle" (mkSpell [
        "en_us"
        "nb"
        "nn"
        "de"
      ]) "English US")
      (util.mkLuaKeymap "n" "<leader>cld" (mkSpell [
        "de"
        "en_us"
        "nb"
        "nn"
      ]) "Deutsch")
      (util.mkLuaKeymap "n" "<leader>clb" (mkSpell [
        "nb"
        "en_us"
        "de"
      ]) "Norsk Bokmål")
      (util.mkLuaKeymap "n" "<leader>cln" (mkSpell [
        "nn"
        "en_us"
        "de"
      ]) "Norsk Nynorsk")

      (util.mkKeymap "n" "<leader>cg" "zg" "Mark as correct")
      (util.mkKeymap "n" "<leader>cw" "zw" "Mark as wrong")
      (util.mkKeymap "n" "<leader>cu" "zuw" "Undo mark")
      (util.mkKeymap "n" "<leader>cc" ":FzfLua spell_suggest<cr>" "See suggestions")
      (util.mkKeymap "n" "<leader>cn" "]s" "Next misspelled word")
      (util.mkKeymap "n" "<leader>cN" "[s" "Previous misspelled word")
      (util.mkKeymap "n" "<leader>cd" ":setlocal nospell<cr>" "Disable spellcheck")
    ];
  };
}
