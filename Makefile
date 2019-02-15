PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

DOCKER_PPA=deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable

YARN_PPA=deb https://dl.yarnpkg.com/debian/ stable main

DOCKER_COMPOSE_VERSION=1.23.2
DOCKER_COMPOSE_URL=https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(shell uname -s)-$(shell uname -m)

GO_VERSION=1.12
ARCHITETURE=$(shell dpkg --print-architecture)
GO_FILE_NAME=go${GO_VERSION}.linux-${ARCHITETURE}.tar.gz
GO_URL=https://dl.google.com/go/${GO_FILE_NAME}

config-bash:
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/bash_functions ~/.bash_functions
	ln -sf `pwd`/bashrc ~/.bashrc
	ln -sf `pwd`/profile ~/.profile

init:
	sudo apt update
	sudo apt install npm vim htop deepin-terminal meld git \
		software-properties-common curl python3-pip \
		apt-transport-https ca-certificates wget -y
	# disable swap
	sudo swapoff -a
	mkdir -p ~/.config/deepin/deepin-terminal/
	cp -f `pwd`/deepin-terminal_config.conf \
		~/.config/deepin/deepin-terminal/config.conf
	ln -sf `pwd`/eslintrc.json ~/.eslintrc.json
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/tern-config ~/.tern-config
	# set deepin terminal as default
	gsettings set org.gnome.desktop.default-applications.terminal \
		exec deepin-terminal

install-go:
	wget ${GO_URL}
	mkdir tmp
	tar xzf ${GO_FILE_NAME} -C tmp/
	sudo cp -r tmp/* /usr/local/
	rm -rf ${GO_FILE_NAME} tmp
	export PATH=$PATH:/usr/local/go/bin

install-yarn:
	sudo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | \
		sudo apt-key add -
	echo "${YARN_PPA}" | \
		sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt update
	sudo apt install yarn -y

install-neovim:
	#install neovim
	sudo apt-add-repository ppa:neovim-ppa/stable -y
	sudo apt update
	sudo apt install neovim silversearcher-ag -y
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
		--create-dirs ${PLUG_URL}
	#install plugins
	yarn global add tern typescript-eslint-parser typescript
	mkdir -p ~/.config/nvim
	ln -sf `pwd`/init.vim ~/.config/nvim/init.vim
	ln -sf `pwd`/prettierrc.yml ~/.prettierrc.yml
	nvim --noplugin +PlugInstall +qall
	cd ~/.config/nvim/plugged/tern_for_vim/ && \
		yarn install
	cd ~/.config/nvim/plugged/YouCompleteMe && \
		python3 install.py --gocode-completer --tern-completer

install-docker:
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
		sudo apt-key add -
	sudo add-apt-repository "${DOCKER_PPA}"
	sudo apt update --fix-missing
	sudo apt-cache policy docker-ce
	sudo apt install docker-ce -y
	sudo usermod -aG docker ${USER}

install-docker-compose:
	sudo curl -L ${DOCKER_COMPOSE_URL} -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

install-kubectl:
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
		sudo apt-key add -
	echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | \
		sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt update
	sudo apt install -y kubectl

install: \
	config-bash \
	init \
	install-go \
	install-yarn \
	install-neovim \
	install-docker \
	install-docker-compose \
	install-kubectl
