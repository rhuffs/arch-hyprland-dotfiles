#!/bin/bash

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$HOME/.config"

echo "🚀 Instalando Arch Linux + Hyprland Dotfiles..."

mkdir -p "$CONFIG"

echo "📦 Instalando pacotes necessários..."

sudo pacman -S --needed \
    hyprland \
    fish \
    neovim \
    waybar \
    git \
    kitty \
    firefox

echo "📁 Copiando configurações..."

cp -r "$DOTFILES/hypr" "$CONFIG/"
cp -r "$DOTFILES/fish" "$CONFIG/"
cp -r "$DOTFILES/nvim" "$CONFIG/"

if [ -d "$DOTFILES/caelestia" ]; then
    cp -r "$DOTFILES/caelestia" "$CONFIG/"
fi

echo "🐚 Configurando Fish..."

chsh -s /usr/bin/fish

echo ""
echo "✅ Instalação concluída!"
echo "🔄 Reinicie a sessão para aplicar as configurações."#!/bin/bash

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$HOME/.config"

echo "🚀 Instalando Arch Linux + Hyprland Dotfiles..."

mkdir -p "$CONFIG"

echo "📦 Instalando pacotes necessários..."

sudo pacman -S --needed \
    hyprland \
    fish \
    neovim \
    waybar \
    git \
    kitty \
    firefox

echo "📁 Copiando configurações..."

cp -r "$DOTFILES/hypr" "$CONFIG/"
cp -r "$DOTFILES/fish" "$CONFIG/"
cp -r "$DOTFILES/nvim" "$CONFIG/"

if [ -d "$DOTFILES/caelestia" ]; then
    cp -r "$DOTFILES/caelestia" "$CONFIG/"
fi

echo "🐚 Configurando Fish..."

chsh -s /usr/bin/fish

echo ""
echo "✅ Instalação concluída!"
echo "🔄 Reinicie a sessão para aplicar as configurações."
