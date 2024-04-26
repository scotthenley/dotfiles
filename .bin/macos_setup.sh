#!/usr/bin/env zsh

cd "$(dirname "${(%):-%N}")"

installSoftware() {
	# Install zsh and required software
	echo "[INFO] Installing tools and software..."
	xargs brew install < homebrew_packages.txt
	
	# Install casks
	brew install --cask iterm2
	brew install --cask 1password
	brew install --cask 1password-cli
	brew install --cask firefox
	brew install --cask rectangle
	brew install --cask notion
	brew install --cask devtoys

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
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
	source ~/.zshrc

	# Install asdf plugins 
	echo "[INFO] Installing asdf plugins..."
	source $HOME/.asdf/asdf.sh

	asdf plugin-add python https://github.com/asdf-community/asdf-python.git
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


read -q "REPLY?I'm about to change the configuration files placed in your home directory. Do you want to continue? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
	doIt
fi


echo ""
echo "[INFO] If there isn't any error message, the process is completed."

