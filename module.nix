{ lib, pkgs, config, ... }:
with lib;                      
let
  cfg = config.services.bbhooks;
  bbhooks = import ./bbhooks.nix;
in {
    options.services.bbhooks = {
        enable = mkEnableOption "bbhooks service";

        webhookPath = mkOption {
            type = types.str;
            default = "/bbhooks";
            description = "Public-facing path to send webhooks to";
        };

        port = mkOption {
            type = types.int;
            default = 33363;
            description = "Public-facing port to send webhooks to";
        };

        isFlake = mkOption {
            type = types.bool;
            default = true;
            description = "Set to true if your NixOS configuration is a nix flake";
        };

        # Later
        # replicator = mkOption {
        #     type = types.bool;
        #     default = true;
        #     description = "Set to true if your NixOS configuration is a nix flake";
        # };

        openFirewall = mkOption {
            type = types.bool;
            default = false;
            description = "Open bbhooks port";
        };

        repo = mkOption {
            default = {};
            description = "Information about the remote SCM repo";
            type = types.submodule {
                options = {

                    useSSH = mkOption {
                        type = types.bool;
                        default = true;
                        description = "Set to true to use SSH to connect to the SCM.";
                    };

                    publicKeyFile = mkOption {
                        type = types.nullOr types.path;
                        default = null;
                        description = "Set to path to SSH public key";
                        example = "/home/user/.ssh/id_ed25519.pub";
                    };

                    url = mkOption {
                        type = types.str;
                        default = null;
                        description = "URL of repo";
                        example = "git@github.com:user/configuration.git";
                    };
                };
            };
        };
    };

    networking.firewall = mkIf cfg.openFirewall {
        allowedTCPPorts = [ cfg.port ];
    };

    systemd.services.bbhooks = {
        wantedBy = [ "multi-user.target" ];
        environment = {
            BBHOOKS_PORT = cfg.port;
            BBHOOKS_PATH = cfg.path;
        };
        serviceConfig = {
            ExecStart = "${pkgs.python39}/bin/python ${bbhooks}/bbhooks.py";
            User = "root";
            Group = "root";
            PrivateTmp = "true";
        };
    };

}