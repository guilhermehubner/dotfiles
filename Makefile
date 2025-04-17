link:
	mkdir -p ~/.config/hypr/
	mkdir -p ~/.config/alacritty
	mkdir -p ~/.config/rofi
	mkdir -p ~/.config/dunst
	mkdir -p ~/.dwm
	mkdir -p ~/.ssh
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/bash_functions ~/.bash_functions
	ln -sf `pwd`/bashrc ~/.bashrc
	ln -sf `pwd`/profile ~/.profile
	ln -sf `pwd`/nvm.bash ~/.nvm.bash
	ln -sf `pwd`/eslintrc.json ~/.eslintrc.json
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/tmux.conf ~/.tmux.conf
	ln -sf `pwd`/alacritty.toml ~/.config/alacritty/alacritty.toml
	ln -sf `pwd`/nvim ~/.config/nvim
	ln -sf `pwd`/prettierrc.yml ~/.prettierrc.yml
	ln -sf `pwd`/rofi_config.rasi ~/.config/rofi/config.rasi
	ln -sf `pwd`/dwmautostart.sh ~/.dwm/autostart.sh
	ln -sf `pwd`/dwmwatcher.sh ~/.dwm/dwmwatcher.sh
	ln -sf `pwd`/dunstrc ~/.config/dunst/dunstrc
	ln -sf `pwd`/gtkrc-2.0 ~/.gtkrc-2.0
	ln -sf `pwd`/gtk-3.0 ~/.config/gtk-3.0
	ln -sf `pwd`/sshconfig ~/.ssh/config
	ln -sf `pwd`/Xkbmap ~/.Xkbmap
	ln -sf `pwd`/hyprland.conf ~/.config/hypr/hyprland.conf
	ln -sf `pwd`/waybar ~/.config/waybar
	mkdir -p ~/.config/mako
	ln -sf `pwd`/mako ~/.config/mako/config
