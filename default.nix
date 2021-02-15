{ config, pkgs, ... }:
{
    ## TODO
    # services.bbhooks = {
    #     enable = true;
    #     webhookPath = "/bbhooks";
    #     port = 33363;
    #     replicator = true; ## Send webhook pings to other devices on your network
    #     replicatorHosts = [ "server2" "desktop1" ];
    #     isFlake = true;
    #     buildFlake = "server1"; ## Specify the flake to build from SCM
    #     repo = {
    #         useSSH = true;
    #         publicKeyFile = ../secrets/id_ed25519.pub;
    #         repoURL = "git@github.com:rpgwaiter/basedbuildhooks.git";
    #     };
    # };
    systemd.services.bbhooks = {
      wantedBy = [ "multi-user.target" ]; 
      after = [ "network.target" ];
      description = "Start listening for build triggers";
      environment = {
          BBHOOKS_PORT = "33363";
          BBHOOKS_PATH = "/bbhooks";
      };
      serviceConfig = {
        Type = "simple";
        ExecStart = ''${pkgs.python39}/bin/python ${import ./bbhooks.nix}/bbhooks.py'';         
        ExecStop = ''${pkgs.s6-linux-utils}/bin/kill -2 $MAINPID'';
      };
   };
}