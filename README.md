# ScreenShot
![Uploading Screenshot From 2025-08-11 21-14-55.png…]()

# My Chezmoi Configs

Welcome to my repo where i share and backup my **Linux configs**, which takes a lot of time to learn and config

# Requeriments

- **Chezmoi**: Git version control and backup
- **Zsh**: Shell
- **Kitty**: Terminal Emulater
- **Starship**: Custom prompt

# installation

Required Applications

```
$ curl -sSfL https://get.chezmoi.io | sh
$ sudo <pkg> zsh kitty
$ curl -sS https://starship.rs/install.sh | sh
```

## Apply Chezmoi

```
$ chezmoi init --apply https://github.com/SoulByte07/My-Configs.git
```

or

```
$ chezmoi init https://github.com/SoulByte07/My-Configs.git
$ chezmoi apply
```
