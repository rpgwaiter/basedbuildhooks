pipeline {
    agent 'master'

    environment {
        PATH = "/run/wrappers/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:$PATH" // Needed for NixOS Hosts
    }

    stages {
        stage("Build") {
            stage("nix-build") {
                steps {
                    sh 'nix-build'
                }
            }
        }
    }
}