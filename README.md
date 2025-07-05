# Neovim configuration

## 1. Vim-plug installation

### Unix, Linux

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### Linux (Flatpak)

```bash
curl -fLo ~/.var/app/io.neovim.nvim/data/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Windows (PowerShell)

```bash
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```

## 2. Folders

```bash
C:\Users\duyvo\AppData\Local\nvim\
├── init.vim                 # File chính
├── core\
│   ├── settings.vim         # Cài đặt cơ bản
│   ├── keymaps.vim         # Phím tắt
│   └── commands.vim        # Custom commands
├── plugins\
│   ├── plugins.vim         # Danh sách plugins
│   ├── ui.vim              # Cấu hình giao diện
│   ├── lsp.vim             # LSP & completion
│   ├── navigation.vim      # Navigation plugins
│   ├── git.vim             # Git plugins
│   └── utils.vim           # Utility plugins
└── ftplugin\
    ├── go.vim              # Go-specific settings
    ├── javascript.vim      # JS/TS settings
    └── html.vim            # HTML/CSS settings
    └── cs.vim              # Cs settings
```

## 3. C# Workflow

```bash
1. Tạo project mới:
cmddotnet new console -n MyProject
cd MyProject
nvim Program.cs

2. Các phím tắt C# hữu ích:

<leader>gd - Go to definition
<leader>ca - Code actions
<leader>cf - Format code
<leader>rb - Build project
<leader>rr - Run project
<leader>rt - Run tests


3. Debug:

:OmniSharpStartServer - Khởi động server
:OmniSharpStopServer - Dừng server
```

## 4. Git WorkFlow
```bash
1. Git Log:

<leader>gl - Git log oneline 
<leader>gL - Git log với graph
<leader>gla - Git log tất cả branches
<leader>glp - Git log với patch
<leader>gls - Git log với statistics

2. File-specific:

<leader>gf - Xem commit history của file hiện tại
<leader>gw - Xem ai đã sửa file này

3. Git Show:

<leader>gsh - Xem commit cuối cùng (HEAD)
<leader>gsc - Git show commit 

4. Git Branch:

<leader>gb - Xem danh sách branches
<leader>gco - Checkout branch
<leader>gcb - Tạo branch mới

5. Commands:

:GitLog - Git log
:GitLogGraph - Git log với graph 
:GitLogAll - Git log tất cả branches
:GitLogPatch - Git log với code changes
:GitLogStat - Git log với statistics
```
