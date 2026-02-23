#!/bin/bash

# 1. Detectar descargador (Resiliencia)
if command -v curl &>/dev/null; then
  FETCH="curl -fsSL https://pixi.sh/install.sh | bash"
elif command -v wget &>/dev/null; then
  FETCH="wget -qO- https://pixi.sh/install.sh | bash"
else
  echo "❌ Error: Necesitas curl o wget." && exit 1
fi

# 2. Instalar Pixi
if ! command -v pixi &>/dev/null; then
  eval "$FETCH"
  export PATH="$HOME/.pixi/bin:$PATH"
fi

# 3. Instalar Just (Motor de tareas)
pixi global install just

# 4. Desplegar configuración modular
echo "📂 Configurando carpetas en $HOME/.config/base..."
mkdir -p "$HOME/.config"
# Copiamos la carpeta del repo a la ubicación final
cp -r .config/base "$HOME/.config/"

# 5. Inyectar el cargador en el .bashrc si no existe
LOADER_LINE='[ -f "$HOME/.config/base/loader.sh" ] && source "$HOME/.config/base/loader.sh"'

# Inyectar en Bash
if [ -f "$HOME/.bashrc" ]; then
  grep -q "base/loader.sh" "$HOME/.bashrc" || echo -e "\n$LOADER_LINE" >>"$HOME/.bashrc"
  echo "✅ Loader inyectado en .bashrc"
  echo "✨ Instalación completada. Reinicia la terminal o haz: source ~/.bashrc"
fi

# Inyectar en Zsh (para corregir tu sesión actual)
if [ -f "$HOME/.zshrc" ]; then
  grep -q "base/loader.sh" "$HOME/.zshrc" || echo -e "\n$LOADER_LINE" >>"$HOME/.zshrc"
  echo "✅ Loader inyectado en .zshrc"
  echo "✨ Instalación completada. Reinicia la terminal o haz: source ~/.zshrc"
fi
