mkdir ~/.config/nvim
cp ./conf/init.vim ~/.config/nvim/init.vim
cd ~
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm i -g yarn
cd ~/.vim/plugged/coc.nvim/
yarn install
echo ""
echo "Open VIM or NeoVIM, then use ':CocInstall coc-clangd'."
