{ config, pkgs, ... }:
{
  imports = [./module.nix];

  services.bbhooks = {
    enable = true;
    webhookPath = "/bbhooks";
    port = 33363;
    # replicator = true; ## Send webhook pings to other devices on your network
    # replicatorHosts = [ "server2" "desktop1" ];
    isFlake = true;
    # buildFlake = "server1"; ## Specify the flake to build from SCM
    repo = {
        useSSH = true;
        publicKeyFile = ../secrets/id_ed25519.pub;
        url = "git@github.com:rpgwaiter/basedbuildhooks.git";
    };
  };
}