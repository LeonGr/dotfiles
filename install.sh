rm ~/.zshrc
ln -s ~/dotfiles/.zshrc ~/.zshrc

rm ~/.config/nvim/init.vim
ln -s ~/dotfiles/init.vim ~/.config/nvim

rm ~/.oh-my-zsh/themes/leon.zsh-theme
ln -s ~/dotfiles/leon.zsh-theme ~/.oh-my-zsh/themes

rm ~/.tmux.conf
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

rm ~/GitClones/tmux-powerline/themes/mytheme.sh
ln -s ~/dotfiles/mytheme.sh ~/GitClones/tmux-powerline/themes/mytheme.sh
