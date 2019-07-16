" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

"插入模式光标形状为|
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[5 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[3 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


"自定义python开发环境
"配置python文件的缩进
autocmd FileType python setlocal et sta sw=4 sts=4

"代码折叠可以只以缩进为依据
autocmd FileType python setlocal foldmethod=indent

"默认展开所有代码
set foldlevel=99

"显示行号
set number

"配置颜色方案
set t_Co=256

"修改leader键
let mapleader = ','
let g:mapleader = ','

"分屏窗口移动 alt=
map j <C-W>j
map k <C-W>k
map h <C-W>h
map l <C-W>l
"窗口关闭
map c <C-W>c

"自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

"保存文件时的格式
set fileencoding=utf-8

"设置vim中默认使用系统剪切板寄存器 “+,则可以直接通过y,p和系统剪切板共享数据
set clipboard=unnamedplus

"光标移动到buffer的顶部和底部时保持5行距离
set scrolloff=5

" 关闭交换文件
set noswapfile

" 突出显示当前列
set cursorcolumn
" 突出显示当前行
set cursorline

"设置文件历史快捷键
nmap <F1> :browse oldfiles<CR>

"一键运行代码
"map <F8> :call CompileRunGcc()<CR>
"   func! CompileRunGcc()
"       exec "w"
"       if &filetype == 'python'
"           exec "!time python3 %"
"       elseif &filetype == 'html'
"           exec "!firefox % &"
"       endif
"   endfunc

"配置插件管理Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

"auto-completion for quotes, parens, brackets, etc
Plugin 'Raimondi/delimitMate'

"code-completion engine for Vim 
Plugin 'Valloric/YouCompleteMe'

"A tree explorer plugin for vim
Plugin 'scrooloose/nerdtree'

"Vim motions on speed
Plugin 'easymotion/vim-easymotion'

"Vim plugin that displays tags in a window, ordered by scope
Plugin 'majutsushi/tagbar'

"Syntax checking hacks for vim
Plugin 'scrooloose/syntastic'

"Lean & mean status/tabline for vim that's light as air
Plugin 'vim-airline/vim-airline'

"run shell commands in background and read output in the quickfix window in
"realtime
Plugin 'skywind3000/asyncrun.vim'

"provides a start screen for Vim
Plugin 'mhinz/vim-startify'

"color scheme
Plugin 'liuchengxu/space-vim-dark'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"不让youcompleteme和Ultisnips默认快捷键冲突
let g:UltiSnipsListSnippets = '<c-l>'
let g:UltiSnipsExpandTrigger = '<s-tab>'
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_python_binary_path = 'python3'
"配置nerdtree
map <F2> :NERDTreeMirror<CR>
map <F2> :NERDTreeToggle<CR>

"配置easymotion
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_smartcase = 1

"配置tagbar
let g:tagbar_width = 30
let g:tagbar_sort = 0
nmap <F3> :TagbarToggle<CR>

"配置YcmCompleter
nnoremap <F4> :YcmCompleter GoTo<CR>
nnoremap <F5> :YcmCompleter GetDoc<CR>

"配置syntastic
set statusline+=%#warningmsg#
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 3
nnoremap <F6> :SyntasticCheck<CR>

"配置airline
"开启tabline
let g:airline#extensions#tabline#enabled = 1
"tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
"映射切换buffer的键位
nnoremap , :bp!<CR>
nnoremap . :bn!<CR>
"只删除没有更改的buffer
nnoremap d :bd<CR>
"映射<alt>num到num buffer
map 1 :b 1<CR>
map 2 :b 2<CR>
map 3 :b 3<CR>
map 4 :b 4<CR>
map 5 :b 5<CR>
map 6 :b 6<CR>
map 7 :b 7<CR>
map 8 :b 8<CR>
map 9 :b 9<CR>


" Quick run via <F8>
nnoremap <F7> :call <SID>Run()<CR>

function! s:Run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python3 %"
    endif
endfunction

" asyncrun now has an option for opening quickfix automatically
let g:asyncrun_open = 8

"在vim内打开terminal用pudb调试
nnoremap <F8> :call <SID>debug()<CR>

function! s:debug()
    exec 'w'
    if &filetype == 'python'
        exec "term ++curwin time python3 -m pudb.run %"
    endif
endfunction

colorscheme space-vim-dark

