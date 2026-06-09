source /usr/share/cachyos-fish-config/cachyos-config.fish

set -gx CARGO_HOME "$HOME/.cargo"
set -gx RUSTUP_HOME "$HOME/.rustup"
set -gx CARGO_BUILD_JOBS "4"
set -gx MAKEFLAGS "-j4"

set -gx PATH "$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
set -gx PATH "$(go env GOPATH)/bin:$PATH"

function fish_greeting
end

fish_add_path /home/amniel/.spicetify
