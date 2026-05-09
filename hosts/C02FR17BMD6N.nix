{ pkgs, ... }:

let
  username = "tinhuynh";
in
{
  system.primaryUser = username;
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";

  # Personal laptop: keep GUI apps minimal and avoid work-specific tooling.
  homebrew = {
    casks = [
      "google-chrome"
      "cursor"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${username} = { pkgs, ... }: {
      home.stateVersion = "25.11";
      programs.home-manager.enable = true;
      home.file.".config/karabiner/karabiner.json".text = builtins.readFile ../files/karabiner.json;
      home.file.".config/kitty/kitty.d/macos.conf".text = builtins.readFile ../files/kitty.conf;

      home.packages = with pkgs; [
        acr-cli
        argocd
        awscli2
        azure-cli
        cmctl
        ffmpeg
        istioctl
        jira-cli-go
        kubelogin
        opencode
        sops
        ssm-session-manager-plugin
        tenv
        tflint
        cookiecutter
        pre-commit
        terraform-docs
        snyk
        gomplate
        kind
        yq-go
      ];
    };
  };
}
