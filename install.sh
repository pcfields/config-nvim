# Install nix package manager
curl -L https://nixos.org/nix/install | sh

# Source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# install packages
nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.git \
	nixpkgs.neovim \
	nixpkgs.tmux \
	nixpkgs.fzf \
	nixpkgs.ripgrep \
	nixpkgs.bat \
	nixpkgs.direnv \
	nixpkgs.stow \
    nixpkgs.fd \
    nixpkgs.gcc \
    nixpkgs.gnumake \

# Install Volta
	curl https://get.volta.sh | bash
	volta install node

# Install individual node packages
#
#
# Install for eslint, json, css, html support
	npm install -g vscode-langservers-extracted 
# Install typescript language server
	npm install -g typescript typescript-language-server
# Install Elm server
	npm install -g elm elm-test elm-format @elm-tooling/elm-language-server
# Install eslint
	npm install -g eslint_d
	npm install -g prettier_d_slim

# Install essential front-end dev node packages
#
	npm install -g vscode-langservers-extracted typescript typescript-language-server eslint_d prettier_d_slim

# Install Rust
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Install Stylua
	cargo install stylua 
