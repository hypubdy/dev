if command -v unzip >/dev/null 2>&1; then
  echo "unzip is already installed."
else
  echo "unzip is not installed. Installing..."
  apt install -y unzip
fi

if command -v fnm >/dev/null 2>&1; then
  echo "fnm is already installed."
else
  echo "fnm is not installed. Installing..."
  curl -fsSL https://fnm.vercel.app/install | bash
fi

if fish -c "omf --version" >/dev/null 2>&1; then
  echo "oh-my-fish is already installed."
else
  echo "oh-my-fish is not installed."
  curl -L https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install -o /tmp/install.fish &&
    fish /tmp/install.fish --noninteractive
  # curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi

# fnm install 20
# echo '125.212.237.4 hostzenifydev' >> /etc/hosts
if command -v nvim >/dev/null 2>&1; then
  echo "nvim is already installed."
else
  echo "nvim is not installed. Installing..."
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
  chmod u+x nvim-linux-x86_64.appimage
  ./nvim-linux-x86_64.appimage --appimage-extract
  mv squashfs-root /
  ln -s /squashfs-root/AppRun /usr/bin/nvim
fi