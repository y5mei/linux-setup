# linux-setup
Commands to setup linux terminal

## 1. Install Oh-My-Zsh, Auto-completion, etc
```bash
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sudo apt install fzf
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
```
## 2. Make sure this .zshrc file get loaded automatically

Modify ~/.zshrc file to only contain this line:

```
source ~/Workspace/linux-setup/.zshrc
```

## 3. Make wayland work for VS Code on Ubuntu

We have to install vscode deb from official website, the one from snap or app centre does not work.

Ref to this [link](https://www.reddit.com/r/Ubuntu/comments/1fcal0s/blurry_text_in_vs_code_ubuntu_2404/)

```
cp /usr/share/applications/code.desktop ~/.local/share/applications/code.desktop

// Make change to Exec lines in this file:

cat ~/.local/share/applications/code.desktop                                                     
[Desktop Entry]
Name=Visual Studio Code
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=/usr/share/code/code --disable-gpu --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto %F
Icon=vscode
Type=Application
StartupNotify=false
StartupWMClass=Code
Categories=TextEditor;Development;IDE;
MimeType=application/x-code-workspace;
Actions=new-empty-window;
Keywords=vscode;

[Desktop Action new-empty-window]
Name=New Empty Window
Name[cs]=Nové prázdné okno
Name[de]=Neues leeres Fenster
Name[es]=Nueva ventana vacía
Name[fr]=Nouvelle fenêtre vide
Name[it]=Nuova finestra vuota
Name[ja]=新しい空のウィンドウ
Name[ko]=새 빈 창
Name[ru]=Новое пустое окно
Name[zh_CN]=新建空窗口
Name[zh_TW]=開新空視窗
Exec=/usr/share/code/code --new-window --disable-gpu --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto %F
Icon=vscode
```

Note I also created a alias for code to include these flags in the .zshrc file so that staring code from terminal can have wayland as well.


## 3. Make ctrl+c/v in VS code terminal copy/paste

First, you want to make sure in VS code setting, when you search `sendKeybindingsToShell`, this is not enabled.

In VS Code, ctrl + shift + p, type "Open keyboard Shortcuts (JSON)" and put the content below inside:

```JSON
[
    // Terminal Copy/Paste (Ctrl+Shift+C/V will still work as well)
    // These ensure Ctrl+C/V work when text is selected in the terminal on Linux.
    // Make sure "terminal.integrated.copyOnSelection": true is in your settings.json
    {
        "key": "ctrl+c",
        "command": "workbench.action.terminal.copySelection",
        "when": "terminalFocus && terminalTextSelected"
    },
    {
        "key": "ctrl+c",
        "command": "workbench.action.terminal.sendSequence",
        "args": { "text": "\u0003" }, // Ctrl+C
        "when": "terminalFocus && !terminalTextSelected"
    },
    {
        "key": "ctrl+v",
        "command": "workbench.action.terminal.paste",
        "when": "terminalFocus"
    },
    {
        "key": "ctrl+shift+V",
        "command": "-workbench.action.terminal.paste",
        "when": "terminalFocus && terminalTextSelected || terminalFocus && terminalProcessSupported"
    },

    // Go to Definition (Ctrl+])
    {
        "key": "ctrl+]",
        "command": "editor.action.revealDefinition",
        "when": "editorTextFocus"
    },

    // Go Back (Ctrl+[)
    {
        "key": "ctrl+[",
        "command": "workbench.action.navigateBack",
        "when": "editorTextFocus"
    }
]
```

## 4. To make ctrl+x, ctrl+e open vim directly in VS code terminal:

```JSON
    {
        "key":"ctrl+e",
        "args": "ctrl+e",
        "when": "terminalFocus"
    },
```

## 5. Install Golang

```bash
curl -L https://go.dev/dl/go1.24.3.linux-amd64.tar.gz -o go1.24.3.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.24.3.linux-amd64.tar.gz
```

## 6. Install Docker

Install docker from here: https://docs.docker.com/desktop/setup/install/linux/ubuntu/
Then make docker sudo-less: https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user

## 7. Install Github CLI

https://github.com/cli/cli/blob/trunk/docs/install_linux.md

Setup git account:

```
  git config --global user.email "meiyaowen@gmail.com"
  git config --global user.name "Yaowen Mei"
```

## 8. Install Bazelisk and depot tools

https://docs.bazel.build/versions/5.3.1/install-bazelisk.html (bazelisk)
https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html#_setting_up (depot tools)

```
$ git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
$ go install github.com/bazelbuild/bazelisk@latest
$ go install github.com/bazelbuild/buildtools/buildifier@latest 
```

Make sure they are in PATH

```
export PATH=$PATH:/usr/local/go/bin # GOROOT, where Go is installed
export PATH=$PATH:$HOME/go/bin # GOPATH, where packages are installed
```
