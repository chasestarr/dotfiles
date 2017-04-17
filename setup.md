installing neovim from homebrew:
`brew install neovim/neovim/neovim`

sylink vim configs to nvim location:
```
mkdir ~/.config
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
```

errors with python on nvim start: 
`pip2 install --user --upgrade neovim`
or refer to nvim-python docs [here](https://neovim.io/doc/user/provider.html#provider-python)
