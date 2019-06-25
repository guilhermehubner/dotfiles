PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

YARN_PPA=deb https://dl.yarnpkg.com/debian/ stable main

DOCKER_COMPOSE_VERSION=1.24.1
DOCKER_COMPOSE_URL=https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(shell uname -s)-$(shell uname -m)

GO_VERSION=1.13
ARCHITETURE=$(shell dpkg --print-architecture)
GO_FILE_NAME=go${GO_VERSION}.linux-${ARCHITETURE}.tar.gz
GO_URL=https://dl.google.com/go/${GO_FILE_NAME}
export PATH:=$(PATH):/usr/local/go/bin:~/go/bin

NVM_VERSION=v0.34.0
export NVM_DIR="${HOME}/.nvm"

config-bash:
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/bash_functions ~/.bash_functions
	ln -sf `pwd`/bashrc ~/.bashrc
	ln -sf `pwd`/profile ~/.profile
	ln -sf `pwd`/nvm.bash ~/.nvm.bash
	mkdir -p ~/.config/terminator
	ln -sf `pwd`/terminator-config ~/.config/terminator/config

init:
	sudo apt update
	sudo apt install vim htop terminator meld git \
		software-properties-common curl python3-pip \
		apt-transport-https ca-certificates wget silversearcher-ag -y
	# disable swap
	sudo swapoff -a
	ln -sf `pwd`/eslintrc.json ~/.eslintrc.json
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/tern-config ~/.tern-config
	# set deepin terminal as default
	gsettings set org.gnome.desktop.default-applications.terminal \
		exec terminator

install-go:
	wget ${GO_URL}
	mkdir tmp
	tar xzf ${GO_FILE_NAME} -C tmp/
	sudo cp -r tmp/* /usr/local/
	rm -rf ${GO_FILE_NAME} tmp

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
	#install neovim
	sudo apt-add-repository ppa:neovim-ppa/stable -y
	sudo apt update
	sudo apt install neovim -y
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
	. ~/.nvm.bash && cd ~/.config/nvim/plugged/YouCompleteMe && \
		python3 install.py --gocode-completer --tern-completer

install-docker:
	sudo curl -fsSL https://get.docker.com | bash
	sudo usermod -aG docker ${USER}

install-docker-compose:
	sudo curl -L ${DOCKER_COMPOSE_URL} -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

install-kubectl:
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
		sudo apt-key add -
	VERSION=`lsb_release -a 2>/dev/null | grep Codename | awk '{print $2}'` && \
		echo "deb http://apt.kubernetes.io/ kubernetes-${VERSION} main" | \
		sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt update
	sudo apt install -y kubectl

install: \
	config-bash \
	init \
	install-go \
	install-nvm \
	install-yarn \
	install-neovim \
	install-docker \
	install-docker-compose \
	install-kubectl
