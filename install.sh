# Install nix package manager
curl -L https://nixos.org/nix/install | sh

# Source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# install NIX packages
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

# Install Node using NVM
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	# https://docs.microsoft.com/en-us/windows/dev-environment/javascript/nodejs-on-wsl

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

# Install Powerline 10K
	https://github.com/romkatv/powerlevel10k

# Install Nerd font 
	https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
	# Copy fonts to global fonts folder (example directory below)
	cp /mnt/c/Users/PeterFields/Downloads/meslo-fonts/* ~/.local/share/fonts
	# Install fontconfig so we can use fc-cache to manually rebuild the font cache
	sudo apt install fontconfig
	fc-cache -fv
	
# Install Rust
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Install Stylua
	cargo install stylua 
