PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

YARN_PPA=deb https://dl.yarnpkg.com/debian/ stable main

DOCKER_COMPOSE_VERSION=1.24.1
DOCKER_COMPOSE_URL=https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(shell uname -s)-$(shell uname -m)

ARCHITETURE=$(shell dpkg --print-architecture)
GO_BASE_URL=https://dl.google.com/go/go
export PATH:=$(PATH):/usr/local/go/bin:~/go/bin

NVM_VERSION=v0.34.0
export NVM_DIR="${HOME}/.nvm"

KUBECTL_VERSION=$(shell curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
KUBECTL_URL=https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl

config-bash:
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/bash_functions ~/.bash_functions
	ln -sf `pwd`/bashrc ~/.bashrc
	ln -sf `pwd`/profile ~/.profile
	ln -sf `pwd`/nvm.bash ~/.nvm.bash
	mkdir -p ~/.config/terminator
	ln -sf `pwd`/terminator-config ~/.config/terminator/config
	mkdir -p ~/.config/autostart
	ln -sf `pwd`/remap.desktop ~/.config/autostart/remap.desktop

init:
	sudo apt update
	sudo apt install vim htop terminator meld git fonts-hack-ttf \
		software-properties-common curl python3-pip setxkbmap xdotool \
		apt-transport-https ca-certificates wget silversearcher-ag -y
	# disable swap
	sudo swapoff -a
	ln -sf `pwd`/eslintrc.json ~/.eslintrc.json
	ln -sf `pwd`/gitconfig ~/.gitconfig
	# set deepin terminal as default
	gsettings set org.gnome.desktop.default-applications.terminal \
		exec terminator

install-go:
	curl --silent https://golang.org/dl/ 2>&1 |\
		ag -o '${GO_BASE_URL}([0-9.]+).linux-${ARCHITETURE}.tar.gz' |\
		sed 's,${GO_BASE_URL}\([0-9.]\+\).linux-${ARCHITETURE}.tar.gz,\1,g' |\
		sort -V | tail -n 1 | xargs -I@ echo ${GO_BASE_URL}@.linux-${ARCHITETURE}.tar.gz |\
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
	#install neovim
	sudo apt-add-repository ppa:neovim-ppa/stable -y
	sudo apt update
	sudo apt install neovim fonts-powerline -y
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
		--create-dirs ${PLUG_URL}
	#install plugins
	. ~/.nvm.bash && npm install -g typescript-eslint-parser typescript
	mkdir -p ~/.config/nvim
	ln -sf `pwd`/init.vim ~/.config/nvim/init.vim
	ln -sf `pwd`/prettierrc.yml ~/.prettierrc.yml
	nvim --noplugin +PlugInstall +qall
	cd ~/.config/nvim/plugged/YouCompleteMe && python3 install.py

install-docker:
	sudo curl -fsSL https://get.docker.com | bash
	sudo usermod -aG docker ${USER}

install-docker-compose:
	sudo curl -L ${DOCKER_COMPOSE_URL} -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

install-kubectl:
	curl -LO ${KUBECTL_URL}
	chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/kubectl

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
