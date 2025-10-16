
# Shells Usage and Config

Usage example bash
```bash
# Встановлення змінної
MY_VAR="Hello"
echo $MY_VAR

# Умовні конструкції
if [ -f file.txt ]; then
    echo "Файл існує"
fi
```

Usage exmple fish
```sh
# Set variable
set MY_VAR "Hello"
echo $MY_VAR

# Conditional statements
if test -f file.txt
    echo "Файл існує"
end
```

Check what shell under usage

```sh
# Current shell
echo $SHELL

# Or
echo $0

# List of available shells
cat /etc/shells
```

How to change shell
```sh
# Temporary Тимчасово (для поточної сесії)
zsh  # або fish, bash тощо

# Permanently (назавжди)
chsh -s /bin/zsh  # або /bin/bash, /usr/bin/fish
```

# Complete ZSH Configuration

Check: ZSH Version

```sh
zsh —version 
```

Install Oh My Zsh!
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Install powerlevel10k

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

Set ZSH Theme: open ~/.zshrc

```sh
vim ~/.zshrc
```

## Find the line that sets ZSH_THEME, and change its value to  "powerlevel10k/powerlevel10k"

```sh
source .zshrc
```

## Configure Theme in wizard

Some additional fixes: Open configuration - Hide username and hostname in right
```sh
vim .p10k.zsh
```

Find and comment

```sh
# context                 # user@hostname
```

If you want reconfigure powerlevel10k run

```sh
p10k configure
```

Open terminal preferences and set font to "MesloLGS NF" (download from


Install Nerd Fonts

```sh
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

fc-cache -fv
```

Restart terminal
Restart p10k configuration

```sh
p10k configure
```

Trix for

ll command

```sh
alias ll='ls -la'
```

mkdir with parents

```sh
mkdir -p some/dir/wtith
```
