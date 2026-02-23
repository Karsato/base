# ~/.config/base/loader.sh

# Asegurar PATH de Pixi
export PATH="$HOME/.pixi/bin:$PATH"

# Cargar componentes si existen
[ -f "$HOME/.config/base/env.sh" ] && source "$HOME/.config/base/env.sh"
[ -f "$HOME/.config/base/aliases.sh" ] && source "$HOME/.config/base/aliases.sh"

# Ejemplo de Alias base
alias base-update="just -f $HOME/.config/base/justfile update-all"
alias base-install-nvim="just -f $HOME/.config/base/justfile install-nvim"
