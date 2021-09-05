PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

YARN_PPA=deb https://dl.yarnpkg.com/debian/ stable main

ARCHITETURE=$(shell dpkg --print-architecture)
export PATH:=$(PATH):/usr/local/go/bin:~/go/bin

NVM_VERSION=$(shell curl -Ls -o /dev/null -w %{url_effective} https://github.com/nvm-sh/nvm/releases/latest |xargs basename)
export NVM_DIR="${HOME}/.nvm"

KUBECTL_VERSION=$(shell curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
KUBECTL_URL=https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl

config-bash:
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/bash_functions ~/.bash_functions
	ln -sf `pwd`/bashrc ~/.bashrc
	ln -sf `pwd`/profile ~/.profile
	ln -sf `pwd`/nvm.bash ~/.nvm.bash

init:
	sudo apt update
	sudo apt install vim htop tmux meld git fonts-hack-ttf xclip \
		software-properties-common curl python3-pip xdotool cpufrequtils \
		apt-transport-https ca-certificates wget silversearcher-ag php composer -y
	# disable swap
	sudo swapoff -a
	ln -sf `pwd`/eslintrc.json ~/.eslintrc.json
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/tmux.conf ~/.tmux.conf
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	~/.tmux/plugins/tpm/scripts/install_plugins.sh
	# Remove annoying ubuntu customization on gnome
	sudo apt remove gnome-shell-extension-ubuntu-dock -y 2>/dev/null; true

install-alacritty:
	sudo docker run -v `pwd`:/export --rm rust:1 bash /export/install_alacritty.sh
	sudo mv alacritty /usr/bin/
	mkdir ~/.icons
	mv alacritty-simple.svg ~/.icons/
	sed -i'' "s,Icon=Alacritty,Icon=${HOME}/.icons/alacritty-simple.svg," Alacritty.desktop
	mv Alacritty.desktop ~/.local/share/applications/
	gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'
	mkdir -p ~/.config/alacritty
	ln -sf `pwd`/alacritty.yml ~/.config/alacritty/alacritty.yml

install-go:
	curl --silent https://golang.org/dl/ 2>&1 |\
		ag -o '/dl/go([0-9.]+).linux-${ARCHITETURE}.tar.gz' |\
		sed 's,/dl/go\([0-9.]\+\).linux-${ARCHITETURE}.tar.gz,\1,g' |\
		sort -V | tail -n 1 | xargs -I@ echo https://golang.org/dl/go@.linux-${ARCHITETURE}.tar.gz |\
		xargs -I@ wget -O go.tar.gz @
	mkdir tmp
	tar xzf go.tar.gz -C tmp/
	sudo cp -r tmp/* /usr/local/
	rm -rf go.tar.gz tmp

install-nvm:
	git clone https://github.com/nvm-sh/nvm.git ${NVM_DIR}
	cd ${NVM_DIR} && git checkout ${NVM_VERSION} && chmod +x nvm.sh && ./nvm.sh
	. ~/.nvm.bash && nvm install --lts

install-yarn:
	sudo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | \
		sudo apt-key add -
	echo "${YARN_PPA}" | \
		sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt update
	sudo apt install yarn -y

install-neovim:
	sudo apt update
	sudo apt install fonts-powerline yapf3 python3-autopep8 flake8 mypy -y
	#install neovim
	curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
	chmod u+x nvim.appimage
	sudo mv nvim.appimage /usr/bin/nvim
	python3 -m pip install --user --upgrade pynvim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
		--create-dirs ${PLUG_URL}
	mkdir -p ~/.config/nvim
	ln -sf `pwd`/nvim/init.vim ~/.config/nvim/init.vim
	ln -sf `pwd`/nvim/plugin ~/.config/nvim/plugin
	ln -sf `pwd`/prettierrc.yml ~/.prettierrc.yml
	nvim --noplugin +PlugInstall +qall

install-docker:
	sudo curl -fsSL https://get.docker.com | bash
	sudo usermod -aG docker ${USER}

install-kubectl:
	curl -LO ${KUBECTL_URL}
	chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/kubectl

install-lsp:
	GO111MODULE=on go get -u golang.org/x/tools/gopls@latest
	. ~/.nvm.bash && npm install -g typescript-eslint-parser typescript pyright
	git clone https://github.com/phpactor/phpactor.git ~/.phpactor
	cd ~/.phpactor && composer install --ignore-platform-reqs --no-dev && \
		sudo ln -sf `pwd`/bin/phpactor /usr/local/bin/phpactor
	# General use LSP
	go get -u github.com/mattn/efm-langserver

install: \
	config-bash \
	init \
	install-go \
	install-nvm \
	install-yarn \
	install-neovim \
	install-docker \
	install-kubectl \
	install-alacritty \
	install-lsp
