{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "nghia";
  home.homeDirectory = "/home/nghia";

  home.packages = with pkgs; [
    lazygit
    zip
    xz
    unzip
    p7zip
    xclip
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

    extraLuaConfig = builtins.readFile ../../nvim/init.lua;
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
        plugin = gruvbox-nvim;
        config = ''vim.cmd[[colorscheme gruvbox]]'';
      }
    ];
    extraPackages = with pkgs; [
      nil
      ripgrep
      nixfmt-rfc-style
    ];
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
  users.defaultUserShell = pkgs.zsh;
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

  home.stateVersion = "25.11";
}
