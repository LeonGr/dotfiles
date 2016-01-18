rm ~/.zshrc
ln -s ~/dotfiles/.zshrc ~/.zshrc

rm -r ~/.config/nvim/autoload
mkdir ~/.config/nvim/autoload
cp ~/dotfiles/plug.vim ~/.config/nvim/autoload
rm -f ~/.config/nvim/init.vim
ln -s ~/dotfiles/init.vim ~/.config/nvim

rm ~/.oh-my-zsh/themes/leon.zsh-theme
ln -s ~/dotfiles/leon.zsh-theme ~/.oh-my-zsh/themes
