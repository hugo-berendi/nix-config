{
  imports = [
    # {{{ snippets
    ./snippets/luasnip.nix
    # }}}
    # {{{ lsp
    ./lsp/lsp.nix
    ./lsp/conform.nix
    ./lsp/trouble.nix
    # }}}
    # {{{ editor
    ./editor/treesitter.nix
    ./editor/icons.nix
    # }}}
    # {{{ cmp
    ./cmp/cmp.nix
    ./cmp/lspkind.nix
    ./cmp/autopairs.nix
    ./cmp/cmp-copilot.nix
    ./cmp/schemastore.nix
    # }}}
    # {{{ ui
    ./ui/dressing.nix
    ./ui/dashboard.nix
    ./ui/lualine.nix
    # }}}
    # {{{ utils
    ./utils/telescope.nix
    ./utils/obsidian.nix
    # }}}
    # {{{ filetypes
    ./filetypes/markdown.nix
    # }}}
  ];

  programs.nixvim.plugins = {
    noice = {
      enable = true;
    };
    ts-comments = {
      enable = true;
    };
    which-key = {
      enable = true;
      settings = {};
    };
  };
}
