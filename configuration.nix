# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #boot.kernel.sysctl."kernel.perf_event_paranoid" = -1;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.defaultUserShell=pkgs.zsh; 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.s4ch1n = {
    isNormalUser = true;
    description = "s4ch1n";
    extraGroups = [ "networkmanager" "wheel" "perf" ];
    packages = with pkgs; [];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];

  # Enable automatic login for the user.
  # services.getty.autologinUser = "s4ch1n";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    kitty # terminal
    tmux
    bemenu
    wofi
    git
    chromium
    waybar
    hyprpaper
    gammastep
    htop
    neofetch
    python3
    util-linux
    gnumake
    gcc
    pkgs.linuxPackages_latest.perf
    bc
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

  programs = {
        hyprland.enable = true;
        sway.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh = {
	  enable = true;
	  enableCompletion = true;
	  syntaxHighlighting.enable = true;

	  shellAliases = {
		  ll = "ls -l";
		  update = "sudo nixos-rebuild switch";
		  vi = "nvim";
	  };
	  ohMyZsh = {
		  enable = true;
		  plugins = [ "git" ];
		  theme = "robbyrussell";
	  };
  };

  programs.neovim = {
	  enable = true;
	  configure = {
		  customRc = ''
			  syntax on
			  set tabstop=2
			  set shiftwidth=2
			  set softtabstop=2
			  set expandtab
			  set ai
			  set nu 
			  set hlsearch
			  set ruler
			  set clipboard+=unnamedplus
			  set wrap linebreak

			  highlight Comment ctermfg=green
			  highlight MatchParen ctermbg=242 guibg=DarkGrey

			  set foldmethod=indent
			  set foldnestmax=10
			  set nofoldenable
			  set foldlevel=1
			  '';
	  };
  };



  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
