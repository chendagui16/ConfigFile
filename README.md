# 实用的vim配置
---------
作为一个工具控，平日里就喜欢配置一些好用的工具。俗话说，工欲善其事，必先利其器，而vim可以说就是这里面的尚方宝剑了。

话说我身边使用vim的人大致分为两种：第一类是由于特殊原因（比如在服务器）无法使用图形界面，所以被迫使用了这样的可以在命令汗工作的编辑工具；第二类是主动去学习这样一款“世界上最好的编辑器”，并真心觉得它很cool的人。我的这篇博客也是面对这样的人。

至于对vim的安利，我就不说了，网上搜索下来可以搜到一大把。我用我个人感受来描述它，就是：学会它，你会自愿抛弃所有其他的编辑器，你会变得更有效率，更cool！然而vim的使用效率是和你对它的配置能力成正比的，网上有很多分享vim配置的博客，但是对于大部分萌新来说，直接使用别人的配置文件确实上手很快，但是每个人的需求不同，不学会有效的自定义，怎么可能用好这一“神器”呢？这也成为我写这一片博客的目的了，不仅仅分享vim的配置，同时也会对配置进行一定的解析。**当然，由于个人接触vim时间也不太长，所以对于高手来说，可能会觉得我写得比较菜，还望指正，共同学习**

> 这篇博客主要是分享一些有用的vim插件，分享一些好的自定义配置。它适合的读者是已经对vim的一些基本操作比较熟悉，并渴望进一步玩转vim的人。

主要配置参考[aixvim](https://github.com/DemonCloud/dotfile).

## 安装我的配置

### 要求

本文中的配置环境主要需要：

 * vim8
* python支持

为什么需要vim8？因为快！vim8可以支持并发，有很多好用的并发的插件不能用岂不是很可惜。至于python支持，主要是为了一些需要python的插件，尤其是youcompleteme，有了它，可以告别IDE了！

#### 怎么看自己的环境是否满足要求？

终端运行

```shell
vim --version
```

观察是否有

```shell
VIM - Vi IMproved 8.0
```

在feature是否有

```shell
+python   # 加号表示支持这种特性
```

#### 如何获得vim8和python支持？

对于mac，可以使用homebrew直接安装即可。

```shell
brew install vim
```

对于linux来说，使用apt-get安装时，默认情况下不会安装8.0，这里给出一个从源码编译的安装方式，可以方便定制。

**安装依赖**

```shell
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git
```

**安装编译vim**

```shell
cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr/local
```

注意到上面开启了很多特性，包括ruby，python，lua等，如果不需要，可以去掉上面的选项。另外对于—with-python-config-dir的选项，需要将后面的路径选择成为自己电脑对应的选项，比如`/usr/lib64/python2.7/config-2.7m-x86_64-linux-gnu`.

另外，如果要使用python3，需要将上面的有关python的选项替换为

```shell
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.5/config \
```

编译

```shell
make && make install
```

按照这个流程，会将vim的命令安装在`/usr/local/bin`的路径下，确认该路径在PATH环境变量下。

##### 没有权限？

有时，我们会碰到没有sudo权限的情况，比如在服务器上，我们只需要将上面configure命令下的选项替换成

```shell
		--prefix=$HOME
```

然后再编译，这时的vim命令会被安装到`$HOME/bin`中，将其加入PATH路径即可。（如果使用zsh，可以将.bashrc替换成.zshrc）

```shell
echo 'export PATH="$HOME/bin:$PATH"' >> $HOME/.bashrc
source $HOME/.bashrc
```

### 安装

1. 终端中输入

```shell
curl -o install_vim.sh https://raw.githubusercontent.com/chendagui16/ConfigFile/master/install_vim.sh

sh install_vim.sh
```

2. 进入vim，输入

```vim
:PlugInstall
```

### 针对的环境

------

**该配置文件使用于linux, mac操作系统，并针对这两个系统做了相对应的键位映射**，为了简便，所有的配置均在`$HOME/.vimrc`的文件中.

## 通用设置

以下是一些有用的通用设置，无关任何插件，自定义了一些快捷键，也打开了一些方便的功能。同时自定了一些有用的功能。

这里主要介绍一些比较特殊的功能，一些比较常见的设置见vimrc的注释。

### 系统剪贴板

```shell
set clipboard=unnamed
```

我们经常会需要将vim中的内容复制到系统剪贴板，或者将系统剪贴板中的文字粘贴到vim中，这个时候我们就需要在复制，粘贴或者剪切时使用一个特殊的前缀`"*`或者`"+`, 比如：

```vim
"*yy  "*p  "*dd 
"+yy  "+p  "+dd
```

加入这个前缀就会使用系统的剪贴板。另外如果clipboard的选项中包含"unamed"的字符串，则就会默认使用系统的剪贴板，因此可以不用输入`"*`或`"+`。

### Leader键

```shell
let mapleader="\<Space>"
let g:mapleader="\<Space>"
```

默认的leader键为`backslash`, 为了方便，我们把leader键改成了`Space`。

### 命令补全

对于vim的命令是可以按`tab`键进行补全的，但是默认的补全确实不太方便。我们通过一些设置可以进行修改

```shell
set wildmenu
set wildmode=longest,full
set completeopt=menu,menuone,longest
set completeopt+=preview
```

可以获得补全效果如下，可以按\<Tab\>和\<Shift\>+\<Tab\>选择

![vim-completation](http://odchpimz0.bkt.clouddn.com/20171008150746687987862.png)

### Undo

我们经常会碰到这样的情况，我们需要编辑完文件后退出，然后发现改错了，需要回退。然而使用vim中的`u`键回退，不能回退到过去的历史，因此我们设置如下配置

```shell
set undofile
set undodir=~/.vim/undo/
```

将所有的历史存储到了`~/.vim/undo`的文件夹。并可以支持无限回溯。

### Tab与空格

有时候，我们会对`tab`和空格进行区分，（比如在python里面，混合使用`tab`和空格作为缩进是会导致运行报错的）。因此我们这里提供了一些特殊的方法区分，并转换。

**高亮Tab**

为了区分`tab`和空格的显示，我们做了如下的设置

```shell
set list listchars=tab:-\ ,extends:>,precedes:<
```

显示的效果如下，`tab`会以一个短横线显示：

![Tab](http://odchpimz0.bkt.clouddn.com/20171009150755168013935.png)

**Space2Tab, Tab2Space**

同时为了也定义了一系列的函数可以转换Tab和Space：Space2Tab, Tab2Space。这两个函数可以支持命令补全，一键运行，可以将Space转换成Tab，也可以将Tab转换成Space。这两个命令不仅仅支持在normal模式下运行，同时也支持在visual模式下指定特殊的范围运行。

### Split切换

vim在不同窗口下切换的默认键位是`Ctrl-w`+`h(jkl)`，这里做了一些修改

```shell
nnoremap <leader>hh <C-w>h
nnoremap <leader>jj <C-w>j
nnoremap <leader>kk <C-w>k
nnoremap <leader>ll <C-w>l
```

### 插入模式下的光标快速定位

```shell
inoremap <C-e> <End>
inoremap <C-f> <Home>
inoremap <C-d> <Esc>VypA
inoremap <C-w> <C-o>w
inoremap <C-b> <C-o>b
```

这里`Ctrl+d`可以快速复制当前行，并粘贴到下一行，类似于很多其他编辑器一样。

### 语法检查和纠正

```shell
" <leader>ss: Spell checking shortcuts
" fold enable settings
nnoremap <leader>ss :setlocal spell!<CR>
nnoremap <leader>sj ]szz
nnoremap <leader>sk [szz
nnoremap <leader>sa zg]szz
nnoremap <leader>sd 1z=
nnoremap <leader>sf z=
```

在normal模式下使用`leader+ss`，可以开启或关闭拼写检查，`leader+sj(k)`，可以将光标定位到下一个（上一个）拼写错误的位置，使用`leader+sd`，表示自动纠正该错误，`leader+sf`可以提供可能的纠正列表，并可以选择纠正项。

## 配置和插件说明:

### 1. 插件管理
对于所有插件来说，最重要的也是最根本的插件就是管理插件了。老牌的管理插件包括[vundle](https://github.com/VundleVim/Vundle.vim)，和[pathogen](https://github.com/tpope/vim-pathogen)。而我这里要强烈推荐的是[vim-plug](https://github.com/junegunn/vim-plug). 它包括以下几大优点：

* 简单，易于安装，相比其他管理插件启动速度快。

* 支持github管理，要安装其他的插件只需要将该插件对应的github名字加入到vimrc即可。例如，你在github中发现了一个支持git的插件**vim-git**，然后要将这个插件加入管理只需要将其仓库名加入vimrc即可。例如：

  ```shell
  " vimrc中双引号后表示注释，tpope/vim-git表示其github的仓库名
  Plug 'tpope/vim-git'
  ```

* 支持外部管理，可任意指定文件夹进行管理，如：

  ```shell
  call plug#begin('~/.vim/bundle')  "将.vim/bundle指定为插件管理文件
  ```

* **杀手锏**，支持并发。这一点是传统的管理插件所不具备的，所有的插件均可以在并发的安装或更新，也就是说你只需要拥有一个配置文件，在网路好的情况下，可以在几分钟内在任何一台机器上安装完你的所有插件。节约下的时间就是金钱啊！

在vim的命令行输入:PlugInstall (可用`tab`补全），即可出现以下画面(以下gif来自官方github）：
![pluginstall](https://raw.githubusercontent.com/junegunn/i/master/vim-plug/installer.gif)

除了PlugInstall外，常用的命令还包括PlugUpdate和PlugClean，可以直接一键更新，clean掉vimrc中已经删除的插件条目。

### 2. 主题

主题的插件包括两个部分，第一个部分是颜色主题，由于我在linux，mac的终端上使用的色彩主题都是[solarized](http://ethanschoonover.com/solarized)的主题，为了保持习惯，这里我也使用了solarized的主题（个人推荐，看着很舒服）。这个主题包含两个配色方案，分别是dark和light。使用的方法是在vimrc中加入

```shell
call plug#begin('~/.vim/bundle')
... " 其他插件
Plug 'altercation/vim-colors-solarized'  "添加插件
...
call plug#end()
... " 其他配置
colorscheme solarized     "使用主题
set background=dark  "选择配色
```

另外需要注意的是，在tmux中使用vim的时候，可能会出现主题颜色失真的情况，这个时候需要设置终端为256色

```shell
set term=screen-256color
或
set t_Co=256
```

#### 配色问题？

在终端中使用vim的时候，如果直接使用solarized的主题，有可能会碰到终端的颜色和vim的颜色叠加的情况，导致显示变得很怪。为了解决这个问题，可以先将终端改成solarized的配色。方法如下：

```shell
cd
git clone git://github.com/seebi/dircolors-solarized.git 
cp ~/dircolors-solarized/dircolors.256dark ~/.dircolors
eval ‘dircolors .dircolors’
echo 'export TERM=xterm-256color' >> $HOME/.bashrc
source $HOME/.bashrc
git clone https://github.com/coolwanglu/gnome-terminal-colors-solarized
cd gnome-terminal-colors-solarized
./set_dark.sh
```

主题所包含的另一个部分是airline，这个主要是提供一个彩色的状态栏，除了好看之外，也能提供不少信息，其中能包括vim模式，文件名，git分支，是否修改，编码方式，结合一些语法插件，甚至可以显示语法错误等。功能比较丰富，推荐使用。使用效果如下：

![airline](https://camo.githubusercontent.com/eb64a0924422c0a70f86cd0c91697b5ff36e5d3f/68747470733a2f2f662e636c6f75642e6769746875622e636f6d2f6173736574732f3330363530322f313036303833312f30356330386161632d313162632d313165332d383437302d6135303661333033376634352e706e67)

在我的配置中，使用airline如下

```shell
call plug#begin('~/.vim/bundle')
... " 其他插件
Plug 'vim-airline/vim-airline'  "添加插件
Plug 'vim-airline/vim-airline-themes'
...
call plug#end()
... " 其他配置
colorscheme solarized     "使用主题
set background=dark  "选择配色
" AirLine Setting
let g:airline_powerline_fonts = 1
let g:airline_theme='serene'
let g:airline_left_sep=''
let g:airline_right_sep=''
```

这里的设置主要是因为我不太喜欢airline的箭头，所以把它取消了，效果如下：

![my_airline](http://odchpimz0.bkt.clouddn.com/20171005150719403895945.png)

#### 字体不正确？

airline使用了powerline的字体，其中包含了很多形象的符号字体，在使用airline时，如果终端中为包含该字体则需要安装：

```shell
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
```

然后需要在对应终端中选择powerline字体

### 3. 文件搜索

文件搜索，常用的vim插件是[ctrlp](https://github.com/kien/ctrlp.vim)，ctrlp的使用方法非常简单，按下`ctrl+p`即可调出搜索框。支持模糊匹配，可以搜索文件，MRU（Most Recently Used), vim-buffer, tags等。

不过我们这里推荐使用的一个插件叫[fzf](https://github.com/junegunn/fzf)，用Go语言实现，利用了vim8的并发机制，可以实现几万文件秒搜。效率感人。而且，它不仅仅支持vim中的使用，也可以支持shell中火tmux中的命令搜索等功能。

在我的配置文件中，对于文件搜索的配置为：

```shell
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'ctrlpvim/ctrlp.vim'
...
set rtp+=~/.fzf
nnoremap z, :FZF --no-mouse .<CR>
```

这里将搜索的快捷键改成了`z,`，不用同时按下，在vim的normal模式下，依次键入即可调出搜索框，尝试一下，你会亲身感受其速度的。

另外，在终端下，使用`ctrl+r`可以搜索命令历史

#### 内容搜索

一般来说，我们搜索文件时只会搜索文件名。但是经常的，我们会搜索文件内容。这时可以使用[ag.vim](https://github.com/rking/ag.vim) 可以批量搜索代码，搜索文件，支持模糊匹配，正则表达式，完爆各种IDE的搜索工具。**需要安装[the_silver_searcher](https://github.com/ggreer/the_silver_searcher)**

```shell
Plug 'rking/ag.vim'
...
" Ag.vim Settings 官方推荐配置
let g:ackprg = "ag --nocolor --nogroup --column"
set grepprg=ag\ --nogroup\ --nocolor
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>  " 搜索快捷键改成了\
```

如下是我在一个工程目录下搜索show_info的结果

![ag](http://odchpimz0.bkt.clouddn.com/20171007150734916375512.png)

这个窗口是可交互的，可以`Enter`进入相应的文件

### 4. 文件buffer类插件

这里使用了常用的[nerdtree](https://github.com/scrooloose/nerdtree) , [nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin) 

```shell
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeDirArrows=0
nnoremap <F2> :NERDTreeToggle<CR>
" =============================== Ignore setting =========================
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
```

这里进行的主要的设置快捷键设置，`F2`可以打开或关闭nerdtree，同时设置了忽略文件加入buffer的管理。同时配合nerdtree-git-plugin插件，可以实现如下gif图显示的git相关操作

![nerdtree-git-plugin](https://camo.githubusercontent.com/3fe0388df11cb787f36e1fa108398fd3f757eef4/687474703a2f2f692e696d6775722e636f6d2f6a534377476a552e6769663f31)

另外针对文件buffer，添加了[mru](https://github.com/yegappan/mru)和[rename](https://github.com/danro/rename.vim)的插件

```shell
Plug 'yegappan/mru'
Plug 'danro/rename.vim'
nnoremap <leader>uh :MRU<CR>
```

**`leader`键在我的配置中改成了`Space`** 这两个插件的使用很简单，输入快捷键`leader+uh`（used history的简称），或在vim命令行输入:MRU，可以调出最近使用的文件名buffer，相当于IDE中的打开最近文件。

rename插件的使用方式即在vim命令行中输入

```vim
:rename {newname}
```

### 5. Git类相关

```shell
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
```

这里的[vim-git](https://github.com/tpope/vim-git) 服务于[vim-fugitive](https://github.com/tpope/vim-fugitive) ，而vim-fugitive可以说是最好用的有关git的vim插件了，它不仅仅提供了有关git的语法高亮，同时也提供了各种有关git的操作接口. 这个插件所包含的功能实在是难以简单的说明，观看其[github](https://github.com/tpope/vim-fugitive)中的screenshot可以了解其强大的功能

常用的命令有：

```vim
:Gedit :Gsplit :Gvsplit :Gtabedit
:Gstatus (在弹出的窗口使用-, p, C进行交互)
:Gcommit
:Gblame (在弹出的窗口中使用o, :Gedit进行交互)
:Ggrep
:Glog
:Gread :Gwrite
:Gdiff
:Gbrowse
:Gmove :Gdelete
...
```

[gitv](https://github.com/gregsexton/gitv) 是一个基于vim-fugitive的拓展，提供了一个命令:Gitv，这个拓展可以打开一个可以交互的git文件窗口，可以查看各种提交历史，diff等

![gitv](https://camo.githubusercontent.com/353e531f32ee489c830236b6f8225cda271192cd/687474703a2f2f7261772e6769746875622e636f6d2f67726567736578746f6e2f676974762f6d61737465722f696d672f676974762d636f6d6d69742e706e67)

[vim-gitgutter](https://github.com/airblade/vim-gitgutter)和[vim-signfy](https://github.com/mhinz/vim-signify)这两个插件提供了几乎一样的功能，但是vim-signify不仅仅支持git，还支持svn等.

同时修改配置

```shell
let g:gitgutter_sign_column_always = 0
let g:gitgutter_max_signs = 99999
```

支持的效果图如下

![gitgutter](https://camo.githubusercontent.com/f88161827e0cbb3144455b9e5c7582fdd5b5fc83/68747470733a2f2f7261772e6769746875622e636f6d2f616972626c6164652f76696d2d6769746775747465722f6d61737465722f73637265656e73686f742e706e67)

另外，这两个插件提供了`]c`,` [c`的命令，这两个命令在使用fugitive的Gdiff时，可以快速跳转到下一个(上一个)有diff的chrunk.

### 6. 编程类插件

#### 语法检查

传统的vim语法检查使用的是[syntastic](https://github.com/vim-syntastic/syntastic)，这个插件由于不是异步的，所以运行速度很慢，会很大程度上拖慢vim的运行速度。异步的语法检查插件推荐[ale](https://github.com/w0rp/ale)， 该插件只支持vim8，由于其运行是异步的，所以基本不会卡。

![ale](https://raw.githubusercontent.com/w0rp/ale/master/img/example.gif)

```shell
Plug 'w0rp/ale'
" Set Ale Cheacker
let g:ale_sign_error = 'o'
let g:ale_sign_warning = '*'
let g:ale_linters = {
	\'python': ['flake8']
	\}
```

ale不仅仅支持语法检查，还支持自动修正。而且支持大部分的语言，如C，C++，python，R，CUDA，Latex，Lua，Markdown，MATLAB，Java，Swift等，详情见[github](https://github.com/w0rp/ale) .

#### 代码注释

[vim-commentary](https://github.com/tpope/vim-commentary)

```shell
Plug 'tpope/vim-commentary'
```

一个快速对代码进行注释的插件，可以针对不同的文件进行不同的注释，而且在已经注释的情况下，运行相同的命令，可以uncomment. 常用的命令是

```shell
gcc  " normal模式下，注释当前行(或清除注释)
{Visual} gc  "Visual模式下，注释当前选中的范围（或清除当前范围的注释）
```

#### 对齐

代码对齐是一个常见的需求， 一个好用的代码对齐的插件是[vim-easy-align](https://github.com/junegunn/vim-easy-align) . 这个插件的使用效果如下：

![vim-easy-align](https://raw.githubusercontent.com/junegunn/i/master/vim-easy-align-slow.gif)

```shell
Plug 'junegunn/vim-easy-align'
" EasyAlign
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
```

按照官方的推荐设置，我们使用`ga`作为对齐的键位映射。

这个插件有两种使用方式，一种为交互式，一种是live交互式。同时该插件也可以通过命令的方式调用。我个人喜欢在visual模式下，键入`ga`来启动交互式对齐，然后在交互式对齐中输入命令。常见的命令如下（其他使用方式参见该插件的help文档）：

|  visual模式后进入交互式  |                    功能                    |                  等效的命令行                  |
| :--------------: | :--------------------------------------: | :--------------------------------------: |
|        =         |                在第一个等号周围对齐                |             :'<,'>EasyAlign=             |
|        2=        |                在第二个等号周围对齐                |            :'<,'>EasyAlign2=             |
|        -=        |               在最后一个等号周围对齐                |            :'<,'>EasyAlign-=             |
|        *=        |                在所有等号周围对齐                 |            :'<,'>EasyAlign*=             |
|       **=        |               等号周围的内容自动调节                |            :'<,'>EasyAlign**=            |
| \<Enter\> + 其他命令 | \<Enter\>可以切换对齐模式，包括做左对齐（默认），右对齐，中心对齐，可重复按下切换 | 右对齐:'<,'>EasyAlign!=中心对齐：:'<,'>EasyAlign!!= |
|  \<Right\>+其他命令  |  对齐的分隔符右方的文字align到分隔符上，\<left\>则为左边的文字   |           :'<,'>EasyAlign=<l1            |
|  \<Down\>+其他命令   |            对齐的分隔符与对齐的文字之间无间隔             |                                          |

该插件的功能远不止于此，还可以自定义对齐的方式，详情可在vim中输入:h vim-easy-align查看

#### 不同语言的插件

```shell
Plug 'kh3phr3n/python-syntax'
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'vim-latex/vim-latex'
```

我的配置文件里面还包含了有关不同语法的插件，这些插件针对不同的文件类型提供了不同的功能，有些只是为了语法高亮，有些则是为了提供快捷编辑，用户可以根据需求来选择添加或删除。

### 7. 补全

#### emmet-vim

[emmet-vim](https://github.com/mattn/emmet-vim) 是一个用来在html格式下补全的插件，一个官方的演示如下：

![emmet](https://raw.githubusercontent.com/mattn/emmet-vim/master/doc/screenshot.gif)

配置如下

```shell
Plug 'mattn/emmet-vim'
...
" Emmet Config
" change <Tab> config , if use [YouCompleteMe]
let g:user_emmet_expandabbr_key ='<Tab>'

let g:user_emmet_settings = {
			\ 'php'     : {
			\ 'extends' : 'html',
			\ 'filters' : 'c',
			\ },
			\ 'xml'     : {
			\ 'extends' : 'html',
			\ },
			\ 'haml'    : {
			\ 'extends' : 'html',
			\ },
			\ 'phtml'    : {
			\ 'extends' : 'html',
			\ }
			\}
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
```

这里将补全的快捷键设置成了`tab`键，当输入“aa/bb/cc”后键入`tab`可以自动拓展为如下：

```html
<aa></aa>
<bb></bb>
<cc></cc>
```

**由于这里使用了`tab`进行补全拓展，所以在youcompleteme中禁用了`tab`**

#### YouCompleteMe

[YouCompleteMe](https://github.com/Valloric/YouCompleteMe) 是一款基于语义的补全插件，其补全功能丝毫不逊色任何IDE，不仅仅可以补全，还可以进行定义，声明的跳转。

![YouCompleteMe](https://camo.githubusercontent.com/1f3f922431d5363224b20e99467ff28b04e810e2/687474703a2f2f692e696d6775722e636f6d2f304f50346f6f642e676966)

[YouCompleteMe](https://github.com/Valloric/YouCompleteMe)是一款需要编译的插件，如果使用vim8，并添加了python支持后，可以使用如下命令进行编译

```shell
cd ~/.vim/bundle/YouCompleteMe
python install.py --clang-completer
```

YouCompleteMe的配置相对比较复杂，如果按照上述命令编译出现问题，可以参考官方[build文档](https://github.com/Valloric/YouCompleteMe)

```shell
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
...
"------------------ YouCompleteMe -------------------
" Linux vim && NeoVim Using YouCompleteMe
if(has("mac"))
	let g:ycm_python_binary_path='/usr/local/bin/python'
else
	let g:ycm_server_python_interpreter='/usr/bin/python'
endif
let g:ycm_auto_trigger = 1
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_add_preview_to_completeopt = 5
let g:ycm_use_ultisnips_completer = 1
let g:ycm_cache_omnifunc = 1
let g:ycm_max_diagnostics_to_display = 0
let g:ycm_key_list_select_completion = ['<C-n>', '<C-j>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<C-k>']
let g:ycm_filetype_blacklist = {
			\ 'tagbar' : 1,
			\ 'qf' : 1,
			\ 'notes' : 1,
			\ 'unite' : 1,
			\ 'text' : 1,
			\ 'vimwiki' : 1,
			\ 'pandoc' : 1,
			\ 'infolog' : 1,
			\ 'mail' : 1,
			\ 'mundo': 1,
			\ 'fzf': 1,
			\ 'ctrlp' : 1
			\}

let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'

nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
```

配置说明：

* 对于C-family的工程，使用YCM-Generator来生成补全的tag
* 针对不同的配置，可能需要自己手动指定python的位置
* 使用`Ctrl+n(p)`或`Ctrl+j(k)`来选择补全（**由于emmet中使用了`tab`，所以这里禁用了`tab`**）
* 对于黑名单中的文件，不进行补全
* 开启了来自ultisnips插件的补全，可以自动拓展成代码片段
* 使用快捷键可以跳转到定义，声明

#### 代码拓展

```shell
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
...
let g:UltiSnipsExpandTrigger="<S-tab>"
```

使用[ultisnips](https://github.com/SirVer/ultisnips) 和[vim-snippets](https://github.com/honza/vim-snippets) 来进行代码拓展，其中vim-snippets是代码拓展的引擎，ultisnips是一些可拓展的代码。两者结合，可以产生如下的效果

![snips](https://camo.githubusercontent.com/296aecf30e1607233814196db6bd3f5f47e70c73/68747470733a2f2f7261772e6769746875622e636f6d2f5369725665722f756c7469736e6970732f6d61737465722f646f632f64656d6f2e676966)

在这份配置里面使用`Shift+tab`可以拓展。

### 8. 通用插件

#### [smooth-scoll](https://github.com/terryma/vim-smooth-scroll)

```shell
Plug 'terryma/vim-smooth-scroll'
...
" Smooth Scroll the terminal
nnoremap <silent> <C-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
nnoremap <silent> <C-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
```

使用这个插件，可以按下`Ctrl-u`, `Ctrl-d`来平滑的翻页，类似于滚动的效果。

#### [Multiple-cursors](https://github.com/terryma/vim-multiple-cursors)

```shell
Plug 'terryma/vim-multiple-cursors'
...
" Multip Cursor
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
```

可以同时编辑多个地方，如下

![multiple-cursors](https://raw.githubusercontent.com/terryma/vim-multiple-cursors/master/assets/example1.gif)

#### [expand-region](https://github.com/terryma/vim-expand-region)

```shell
Plug 'terryma/vim-expand-region'
...
map KK <Plug>(expand_region_expand)
map JJ <Plug>(expand_region_shrink)
```

在visualize的模式下，按`KK`或`JJ`可以拓展或收缩选中的区域

![expand-region](https://camo.githubusercontent.com/64655fb5626161f9245df9b562ff8584fc61067f/68747470733a2f2f7261772e6769746875622e636f6d2f74657272796d612f76696d2d657870616e642d726567696f6e2f6d61737465722f657870616e642d726567696f6e2e676966)

#### 复制的区域闪烁

这里使用了两个轻量的插件，实现了使得复制时，所选择内容闪烁。

```shell
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
...
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
```

#### [incsearch](https://github.com/haya14busa/incsearch.vim)

这个属于增强vim的默认搜索的插件，使用起来跟默认的搜索一样，但是在显示上会比较友好。

```shell
Plug 'haya14busa/incsearch.vim'
...
" Vim incsearch
let g:vim_search_pulse_disable_auto_mappings = 1
let g:incsearch#auto_nohlsearch = 1
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map n <Plug>(incsearch-nohl-n)zzzv
map N <Plug>(incsearch-nohl-N)zzzv
map * <Plug>(incsearch-nohl-*)zzzv
map # <Plug>(incsearch-nohl-#)zzzv
map g* <Plug>(incsearch-nohl-g*)zzzv
map g# <Plug>(incsearch-nohl-g#)zzzv
```

这里的配置是将incsearch的搜索替换默认的搜索。

#### [surround](https://github.com/tpope/vim-surround)

一个快速编辑surround的插件

```shell
Plug 'tpope/vim-surround'
```

使用方法非常简单，参见其[github](https://github.com/tpope/vim-surround)。常用的命令，比如针对hello，我们想给其加双引号，只需要按下`ysiw"`，即可编程“hello"，然后在其上按下`cs“)`，即可其替换成（hello）。

#### [repeat](https://github.com/tpope/vim-repeat)

```shell
Plug 'tpope/vim-repeat'
```

我们经常会使用`.`来重复上次的命令，然而，使用这个操作是不能重复Plugin map的操作，使用这个插件，即可完成这样的功能。

