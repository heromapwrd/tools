"""""""""""""""""""""""""""""""""
" => vim-plug
"""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
" tag自动生成插件
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
" 编译运行
Plug 'skywind3000/asyncrun.vim'
" 语法检查
Plug 'w0rp/ale'
Plug 'mhinz/vim-signify'
" 文本对象
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cc', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'
" 编辑辅助
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-unimpaired'
" 代码补全
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer',  'for': ['c', 'cc', 'cpp'] }
Plug 'Valloric/YouCompleteMe', {'on': []}
"Plug 'AutoComplPop'
" 搜索
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" 项目树
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
" 这个插件可以显示文件的Git增删状态
"Plug 'Xuyuanp/nerdtree-git-plugin'
"
" 符号列表
Plug 'vim-scripts/taglist.vim', {'on': 'TlistToggle'}
"Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
" 括号/引号匹配
Plug 'Raimondi/delimitMate'
" 注释
Plug 'preservim/nerdcommenter'
" 源文件与头文件切换
Plug 'vim-scripts/a.vim'
Plug 'justinmk/vim-dirvish'
" 函数显示参数
Plug 'Shougo/echodoc.vim'
" 状态栏
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
"Plug 'mengelbrecht/lightline-bufferline'
" 函数跳转
Plug 'wesleyche/SrcExpl'
" vim启动优化
Plug 'tweekmonster/startuptime.vim'
Plug 'dstein64/vim-startuptime'
call plug#end()
"""""""""""""""""""""""""""""""""
" => gutentags
"""""""""""""""""""""""""""""""""
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
"if executable('gtags-cscope') && executable('gtags')
"	let g:gutentags_modules += ['gtags_cscope']
"endif
" 配置 ctags 的参数 "
" ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+liaS --extra=+q
" ctags --list-kinds=c++
" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0
" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

"""""""""""""""""""""""""""""""""
" => AsyncRun
"""""""""""""""""""""""""""""""""
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 设置项目标志
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
"" 使用cmake生成Makefile
"nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>
"" 单文件：运行
"nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) -mode=4 "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
"" 项目：测试
"nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>
"" 项目：编译
"nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
"" 项目：运行
"nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw -mode=4 make run <cr>
"" 单文件：编译
"nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

"""""""""""""""""""""""""""""""""
" => ALE
"""""""""""""""""""""""""""""""""
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta

"""""""""""""""""""""""""""""""""
" => signify
"""""""""""""""""""""""""""""""""
"set signcolumn=yes

"""""""""""""""""""""""""""""""""
" => 文本对象
"""""""""""""""""""""""""""""""""
"diw 删除光标所在单词，ciw 改写单词，vip 选中段落等，ci"/ci( 改写引号/括号中的内容)
"i, 和 a, ：参数对象，写代码一半在修改，现在可以用 di, 或 ci, 一次性删除/改写当前参数
"ii 和 ai ：缩进对象，同一个缩进层次的代码，可以用 vii 选中，dii / cii 删除或改写
"if 和 af ：函数对象，可以用 vif / dif / cif 来选中/删除/改写函数的内容

"""""""""""""""""""""""""""""""""
" => 编辑辅助
"""""""""""""""""""""""""""""""""
set switchbuf=useopen

"""""""""""""""""""""""""""""""""
" => YouCompleteCode
"""""""""""""""""""""""""""""""""
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-n>'
set completeopt=menu,menuone

"noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
augroup load_ycm
    autocmd!
    autocmd InsertEnter * call plug#load('YouCompleteMe') | autocmd! load_ycm
augroup END

"""""""""""""""""""""""""""""""""
" => LeaderF
"""""""""""""""""""""""""""""""""
"let g:Lf_ShortcutF = '<C-j>'
"let g:Lf_ShortcutB = 'b'
"noremap <C-j> :Leaderf file<cr>
"noremap <C-k> :Leaderf mru<cr>
"noremap <C-l> :Leaderf function<cr>
"noremap <F5> :Leaderf gtags<cr>
"noremap  :Leaderf buffer<cr>
"cnoremap lfo<cr>  Leaderf file<cr>
"cnoremap lfm<cr>  Leaderf mru<cr>
"cnoremap lff<cr>  Leaderf function<cr>
"cnoremap lfgt<cr> Leaderf gtags<cr>
"cnoremap lft<cr>  Leaderf tag<cr>
"cnoremap lfb<cr>  Leaderf buffer<cr>
"cnoremap lfbt<cr> Leaderf bufTag<cr>
"cnoremap lfw<cr>  Leaderf window<cr>
"cnoremap lfs<cr>  Leaderf self<cr>
noremap <leader>m  :Leaderf mru<cr>
noremap <leader>o  :Leaderf function<cr>
noremap <leader>tg :Leaderf gtags<cr>
noremap <leader>t  :Leaderf tag<cr>
noremap <leader>tb :Leaderf bufTag<cr>
noremap <leader>w  :Leaderf window<cr>
noremap <leader>s  :Leaderf self<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 1
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_GtagsHigherThan6_6_2 = 0
autocmd BufNewFile,BufRead X:/yourdir* let g:Lf_WildIgnore={'file':['*.vcproj', '*.vcxproj'],'dir':['*bazel*']}

"""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""
" F3 打开/关闭
noremap <silent> <F3> :NERDTreeToggle<CR>
" 当不带参数打开Vim时自动加载项目树
set rtp+=~/.vim/plugged/nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 当所有文件关闭时关闭项目树窗格
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" 不显示这些文件
let NERDTreeIgnore=['\.pyc$', '\.swp', '\~$', 'node_modules'] "ignore files in NERDTree
" 不显示项目树上额外的信息，例如帮助、提示什么的
let NERDTreeMinimalUI=1

" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 设置宽度
let NERDTreeWinSize=30
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" 显示书签列表
let NERDTreeShowBookmarks=1
" 当vim打开一个目录时，nerdtree自动使用
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" 改变nerdtree的箭头
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"""""""""""""""""""""""""""""""""
" => taglist
"""""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd='ctags'
let Tlist_Show_One_File=1             "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Sort_Type ='name'           "按名称排序 
let Tlist_WinWidt =30                 "设置taglist的宽度             
let Tlist_Exit_OnlyWindow=1           "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window=1          "在右侧窗口中显示taglist窗口
let Tlist_GainFocus_On_ToggleOpen = 1 "Taglist窗口打开时，立刻切换为有焦点状态
"let Tlist_Auto_Open=1                "打开vim时自动打开taglist
"let Tlist_Process_File_Always=1      "taglist始终解析文件中的tag，不管taglist窗口有没有打开
noremap <silent> <F4> :TlistToggle<cr>

"""""""""""""""""""""""""""""""""
" tagbar
"""""""""""""""""""""""""""""""""
"let g:tagbar_width = 30
"nmap <F12> :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""
" => echodoc
"""""""""""""""""""""""""""""""""
" 隐藏mode栏
set noshowmode

"""""""""""""""""""""""""""""""""
" => airline
"""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '|'
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
map <c-Left> :bp<CR>    " 切换到上一个
map <c-Right> :bn<CR>   " 切换到下一个
"map <F2> :bd<CR>        " 关闭当前窗口
map 11 :b1<CR>          " 切换到编号1
map 22 :b2<CR>          " 切换到编号2
map 33 :b3<CR>          " 切换到编号3
map 44 :b4<CR>          " 切换到编号4
map 55 :b5<CR>          " 切换到编号5
map 66 :b6<CR>          " 切换到编号6
map 77 :b7<CR>          " 切换到编号7
map 88 :b8<CR>          " 切换到编号8
map 99 :b9<CR>          " 切换到编号9
map 00 :b10<CR>         " 切换到编号10

"""""""""""""""""""""""""""""""""
" source explorer
"""""""""""""""""""""""""""""""""
map <F9> :SrcExplToggle<CR>
let g:SrcExpl_winHeight = 8
let g:SrcExpl_refreshTime = 100
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_jumpKey = '<ENTER>'
let g:SrcExpl_isUpdateTags = 0

"""""""""""""""""""""""""""""""""
" cscope
"""""""""""""""""""""""""""""""""
nmap <A-S> :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <A-G> :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <A-C> :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <A-T> :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <A-E> :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <A-F> :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <A-I> :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <A-D> :cs find d <C-R>=expand("<cword>")<CR><CR>

"""""""""""""""""""""""""""""""""
" gtags
"""""""""""""""""""""""""""""""""
set cscopetag " 使用 cscope 作为 tags 命令
"set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_Gtagsconf = '/usr/local/share/gtags/gtags.conf'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

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
set tags=./.tags;,.tags
