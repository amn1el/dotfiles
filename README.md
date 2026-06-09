# dotfiles

A personal customized, interactive, and minimal scrolling-tiling Wayland development environment running on **CachyOS**, driven by the **Niri** compositor and enhanced by **Noctalia-shell**.

<p align="center">
  <img src="https://img.shields.io/badge/OS-CachyOS%20%7C%20Arch-0f80c1?style=for-the-badge&logo=arch-linux" alt="OS">
  <img src="https://img.shields.io/badge/WM-Niri-7aa2f7?style=for-the-badge" alt="WM">
  <img src="https://img.shields.io/badge/Shell-Fish-00a2ff?style=for-the-badge&logo=fish" alt="Shell">
  <img src="https://img.shields.io/badge/Terminal-Alacritty-ef7e32?style=for-the-badge&logo=alacritty" alt="Terminal">
</p>

---

## 🛠️ Core Stack

| Component | Software | Description |
| :--- | :--- | :--- |
| **OS** | [CachyOS](https://cachyos.org/) | Optimized Arch-based distribution |
| **Compositor** | [Niri](https://github.com/YaL标记/niri) | Scrollable-tiling Wayland compositor |
| **Desktop Shell** | [Noctalia-shell](https://github.com/noctalia-shell) | Custom panel, launcher, and system components |
| **Terminal** | [Alacritty](https://alacritty.org/) | GPU-accelerated terminal emulator |
| **Shell** | [Fish](https://fishshell.com/) | Smart and user-friendly command-line shell |
| **File Manager** | [Nautilus](https://apps.gnome.org/Nautilus/) | Clean GNOME file manager configured with grid view |
| **Theme** | `adw-gtk3-dark` | Seamless Libadwaita dark ecosystem theme |

---

## 📁 Repository Structure

```text
├── config/
│   ├── alacritty/       # Terminal styles & opacity
│   ├── fastfetch/       # System fetch layout
│   ├── fish/            # Shell aliases and prompt
│   ├── niri/            # Scroll inputs, keybinds, and layout rules
│   └── noctalia/        # UI Shell configurations
├── home/
│   └── wallpapers/      # Personal collection of desktop backgrounds
└── install.sh           # Interactive deployment script
```