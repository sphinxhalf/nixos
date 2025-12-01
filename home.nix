{ config, pkgs, ... }:

{
  home.username = "nghia";
  home.homeDirectory = "/home/nghia";

  home.packages = with pkgs; [
    lazygit
    zip
    xz
    unzip
    p7zip
    protonvpn-gui
    xclip
    protonvpn-gui
    brave
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "nghia";
    userEmail = "nghiavu7636@gmail.com";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = builtins.readFile ./nvim/init.lua;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
      conform-nvim
      {
        type = "lua";
        plugin = nord-nvim;
        config = ''vim.cmd[[colorscheme nord]]'';
      }
    ];
    extraPackages = with pkgs; [
      nil
      ripgrep
      nixfmt-rfc-style
    ];
  };

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Nord";
      font-size = 16;
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol$state]($style) ";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = [
      "rm *"
      "pkill *"
      "cp *"
    ];
  };

  home.stateVersion = "25.05";
}
