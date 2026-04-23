# if command -v unzip >/dev/null 2>&1; then
#   echo "unzip is already installed."
# else
#   echo "unzip is not installed. Installing..."
#   apt install -y unzip
# fi

# if command -v fnm >/dev/null 2>&1; then
#   echo "fnm is already installed."
# else
#   echo "fnm is not installed. Installing..."
#   curl -fsSL https://fnm.vercel.app/install | bash
# fi

# if fish -c "omf --version" >/dev/null 2>&1; then
#   echo "oh-my-fish is already installed."
# else
#   echo "oh-my-fish is not installed."
#   curl -L https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install -o /tmp/install.fish &&
#     fish /tmp/install.fish --noninteractive
#   # curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
# fi

# # fnm install 20
# # echo '125.212.237.4 hostzenifydev' >> /etc/hosts
# if command -v nvim >/dev/null 2>&1; then
#   echo "nvim is already installed."
# else
#   echo "nvim is not installed. Installing..."
#   curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
#   chmod u+x nvim-linux-x86_64.appimage
#   ./nvim-linux-x86_64.appimage --appimage-extract
#   rm nvim-linux-x86_64.appimage
#   mv squashfs-root /
#   ln -s /squashfs-root/AppRun /usr/bin/nvim
# fi


#!/usr/bin/env bash
# Install script: unzip, fnm, oh-my-fish, neovim
# fnm được cấu hình cho cả bash và fish

# ---------- unzip ----------
if command -v unzip >/dev/null 2>&1; then
  echo "unzip is already installed."
else
  echo "unzip is not installed. Installing..."
  apt install -y unzip
fi

# ---------- fnm ----------
if command -v fnm >/dev/null 2>&1; then
  echo "fnm is already installed."
else
  echo "fnm is not installed. Installing..."
  # --skip-shell: không để installer tự ghi vào .bashrc, tự cấu hình tay cho cả 2 shell
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

  FNM_DIR="$HOME/.local/share/fnm"

  # --- Cấu hình cho bash ---
  if ! grep -q 'fnm env' "$HOME/.bashrc" 2>/dev/null; then
    echo "Configuring fnm for bash..."
    cat >> "$HOME/.bashrc" <<EOF

# fnm
export PATH="$FNM_DIR:\$PATH"
eval "\$(fnm env --use-on-cd --shell bash)"
EOF
  fi

  # --- Cấu hình cho fish ---
  mkdir -p "$HOME/.config/fish/conf.d"
  FISH_CONF="$HOME/.config/fish/conf.d/fnm.fish"
  if [ ! -f "$FISH_CONF" ]; then
    echo "Configuring fnm for fish..."
    cat > "$FISH_CONF" <<EOF
set -gx PATH "$FNM_DIR" \$PATH
fnm env --use-on-cd --shell fish | source
EOF
  fi

  # Cho phiên shell hiện tại dùng được luôn không cần reload
  export PATH="$FNM_DIR:$PATH"
fi

# ---------- oh-my-fish ----------
if fish -c "omf --version" >/dev/null 2>&1; then
  echo "oh-my-fish is already installed."
else
  echo "oh-my-fish is not installed."
  curl -L https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install -o /tmp/install.fish &&
    fish /tmp/install.fish --noninteractive
fi

# fnm install 20
# echo '125.212.237.4 hostzenifydev' >> /etc/hosts

# ---------- neovim ----------
if command -v nvim >/dev/null 2>&1; then
  echo "nvim is already installed."
else
  echo "nvim is not installed. Installing..."
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
  chmod u+x nvim-linux-x86_64.appimage
  ./nvim-linux-x86_64.appimage --appimage-extract
  rm nvim-linux-x86_64.appimage
  mv squashfs-root /
  ln -s /squashfs-root/AppRun /usr/bin/nvim
fi

echo ""
echo "✓ Done. Mở shell mới (bash hoặc fish) để fnm có sẵn."