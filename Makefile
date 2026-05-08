.POSIX:
.PHONY: default build update brew

default: build

/nix:
	curl -L https://nixos.org/nix/install | sh

brew:
	@if command -v brew >/dev/null 2>&1; then \
		echo "Homebrew already installed at $$(command -v brew)"; \
	else \
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/brew-install.sh; \
		NONINTERACTIVE=1 bash /tmp/brew-install.sh; \
	fi

~/.ssh/id_ed25519:
	ssh-keygen -t ed25519 -f "$@"

~/.git: ~/.ssh/id_ed25519
	cd ~ \
		&& git init \
		&& git config status.showUntrackedFiles no \
		&& git remote add origin https://github.com/khuedoan/dotfiles \
		&& git pull origin master \
		&& git remote set-url origin git@github.com:khuedoan/dotfiles

build: /nix brew
	sudo /nix/var/nix/profiles/default/bin/nix \
		 --experimental-features 'nix-command flakes' \
		run \
		nix-darwin/nix-darwin-25.11#darwin-rebuild \
		-- \
		switch --flake .

update:
	nix flake update
