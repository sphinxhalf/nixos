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

    extraLuaConfig = builtins.readFile ./nvim/init.lua;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      conform-nvim
      {
        type = "lua";
        plugin = gruvbox-material-nvim;
        config = ''require('gruvbox-material').setup()'';
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
      add_newline = true;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  home.stateVersion = "25.05";
}
