#!/usr/bin/env zsh

cd "$(dirname "${(%):-%N}")"

installSoftware() {
	# Install zsh and required software
	echo "[INFO] Installing tools and software..."
	xargs brew install < homebrew_packages.txt

	# Install Wezterm
	brew install --cask wezterm
}

installBrew() {
	if hash brew 2>/dev/null; then
		echo "[INFO] Brew already installed."
	else
		echo "[INFO] Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi
}

updateBrew() {
	if hash brew 2>/dev/null; then
		echo "[INFO] Updating Homebrew..."
		brew update
	fi
}

installAsdf() {
	# Clone repository
	echo "[INFO] Cloning asdf repository..."
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	source ~/.zshrc

	# Install useful plugins (at least for me :D)
	echo "[INFO] Installing asdf plugins..."
	source $HOME/.asdf/asdf.sh

	asdf plugin-add python
	asdf plugin-add golang https://github.com/asdf-community/asdf-golang.git
	echo . ~/.asdf/plugins/golang/set-env.zsh
	asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	asdf plugin-add java https://github.com/halcyon/asdf-java.git
	asdf plugin-add direnv https://github.com/asdf-community/asdf-direnv.git
	asdf direnv setup --shell zsh --version latest
}

installRust() {
	echo "[INFO] Installing Rust and tools..."
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

installTpm() {
	echo "[INFO] Cloning Tmux Plugin Manager.."
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

doIt() {
	installBrew
	updateBrew
	installSoftware
	installAsdf
	installRust
	installTpm
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "I'm about to change the configuration files placed in your home directory. Do you want to continue? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi

echo ""
echo "[INFO] If there isn't any error message, the process is completed."

