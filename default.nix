{ config, pkgs, ... }:
{
    ## TODO
    # services.bbhooks = {
    #     enable = true;
    #     webhookPath = "/bbhooks";
    #     port = 33363;
    #     repo = {
    #         useSSH = true;
    #         publicKeyFile = ../secrets/id_ed25519.pub;
    #         isGithub = true;
    #         repoURL = "git@github.com:rpgwaiter/basedbuildhooks.git";
    #     };
    # };
    systemd.services.bbhooks = {
      wantedBy = [ "multi-user.target" ]; 
      after = [ "network.target" ];
      description = "Start listening for build triggers";
      serviceConfig = {
        Type = "simple";
        ExecStart = ''${python39}/bin/python3 ${import ./bbhooks.nix}/bbhooks.py'';         
        ExecStop = ''${pkgs.s6-linux-utils}/bin/kill -2 $MAINPID'';
      };
   };
}