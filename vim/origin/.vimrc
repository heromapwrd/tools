"""""""""""""""""""""""""""""""""
" => 全局配置
"""""""""""""""""""""""""""""""""
" 关闭兼容模式
set nocompatible
" 设置历史记录步数
set history=100
" 开启相关插件
filetype on
filetype plugin on
filetype indent on
" 当文件在外部被修改时，自动更新该文件
set autoread
" 激活鼠标的使用
set mouse-=a
"""""""""""""""""""""""""""""""""
" => 字体和颜色
"""""""""""""""""""""""""""""""""
" 开启语法
syntax enable
" 设置字体
set guifont=dejaVu\ Sans\ MONO\ 10
" 设置配色
colorscheme desert
" 高亮显示当前行
set cursorline
hi cursorline guibg=#00ff00
hi CursoColumn guibg=#00ff00
"""""""""""""""""""""""""""""""""
" => 代码折叠功能
"""""""""""""""""""""""""""""""""
" 激活折叠功能
set foldenable
set foldmethod=manual
" 设置折叠区域的宽度
set foldcolumn=0
" 设置折叠层数为3
setlocal foldlevel=3
" 设置为自动关闭折叠
set foldclose=all
" 用空格键来代替zo和zc快捷键实现开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"""""""""""""""""""""""""""""""""
" => 文字处理
"""""""""""""""""""""""""""""""""
" 使用空格来替换Tab
set expandtab
" 设置所有的Tab和缩进为4个空格
set tabstop=2
" 设定 << 和 >> 命令移动时的宽度为4
set shiftwidth=2
" 使得按退格键时可以一次删掉4个空格
set softtabstop=2
set smarttab
" 缩进，自动缩进（继承前一行的缩进）
set ai
" 智能缩进
set si
" 自动换行
set wrap
" 设置软宽度
set sw=2
"""""""""""""""""""""""""""""""""
" => Vim 界面
"""""""""""""""""""""""""""""""""
" Turn on Wild menu
set wildmenu
" 显示标尺
set ruler
" 设置命令行的高度
set cmdheight=1
" 显示行数
set nu
set lz
" 设置退格
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" 设置魔术
set magic
" 关闭错误信息响铃
set noerrorbells
" 关闭使用可视响铃代替呼叫
set novisualbell
" 显示匹配的括号
set showmatch
set mat=2
" 搜索时高亮显示搜索到的内容
set hlsearch
" 搜索时不区分大小写
set ignorecase
"""""""""""""""""""""""""""""""""
" => 编码设置
"""""""""""""""""""""""""""""""""
" 设置编码
set encoding=utf-8
" 设置文件编码
set fileencodings=utf-8
" 设置终端编码
set termencoding=utf-8
"""""""""""""""""""""""""""""""""
" => 其他设置
"""""""""""""""""""""""""""""""""
" 开启新行时使用智能自动缩进
set smartindent
set cin
set showmatch
" 隐藏工具栏
set guioptions-=T
" 隐藏菜单栏
set guioptions-=m
" 置空错误铃声的终端代码
set vb t_vb=
" 显示状态栏
set laststatus=2
" 粘贴不换行问题的解决方法
set pastetoggle=<F9>
" 设置背景色
set background=dark
" 设置高亮相关
" highlight Search ctermbg=black ctermfg=white guifg=white guibg=black
highlight Search term=reverse term=bold ctermfg=3 ctermbg=2 gui=reverse guifg=slategrey guibg=khaki
" 在shell脚本的开头自动增加解释器及作者版本版权信息
autocmd BufNewFile *.py,*.cc,*.sh,*.java exec ":call SetTitle()"
func SetTitle()
  if expand("%:e") == 'sh' 
    call setline(1, "#!/bin/bash")
    call setline(2, "#########################################################")
    call setline(3, "# FileName   :".expand("%"))
    call setline(4, "# Author     :Quanbo Liu")
    call setline(5, "# Email      :quanbo.liu@enflame-tech.com")
    call setline(6, "# Time       :".strftime("%F %T"))
    call setline(7, "# Version    :V1.0")
    call setline(8, "# Description:")
    call setline(9, "#########################################################")
  endif
  if expand("%:e") == 'py'
    call setline(1, "#########################################################")
    call setline(2, "# FileName   :".expand("%"))
    call setline(3, "# Author     :Quanbo Liu")
    call setline(4, "# Email      :quanbo.liu@enflame-tech.com")
    call setline(5, "# Time       :".strftime("%F %T"))
    call setline(6, "# Version    :V1.0")
    call setline(7, "# Description:")
    call setline(8, "#########################################################")
  endif
endfunc
" 记住上次编辑位置，再次打开后自动跳转到此位置
if has("autocmd")                                                          
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif                                                        
endif
set tags=./tags,../tags,./*/tags;
map <F2> :NERDTreeMirror<CR>
map <F2> :NERDTreeToggle<CR>
"autocmd VimEnter * NERDTree
