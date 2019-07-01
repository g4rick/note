"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader="\<space>"

" Enable filetype plugins
filetype plugin on
filetype indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 切换窗口
nnoremap <leader>1 :exec "1wincmd w"<CR>
nnoremap <leader>2 :exec "2wincmd w"<CR>
nnoremap <leader>3 :exec "3wincmd w"<CR>
nnoremap <leader>4 :exec "4wincmd w"<CR>
nnoremap <leader>5 :exec "5wincmd w"<CR>
nnoremap <leader>6 :exec "6wincmd w"<CR>
nnoremap <leader>7 :exec "7wincmd w"<CR>
nnoremap <leader>8 :exec "8wincmd w"<CR>
nnoremap <leader>9 :exec "9wincmd w"<CR>

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid
" 切换buffers
nnoremap <leader>bb :buffers<cr>:b<space>
" 下一个缓冲区
nnoremap <tab> :bn<cr>
nnoremap <S-tab> :bp<cr>
" 关闭缓冲区
nnoremap <leader>bq :bp<bar>sp<bar>bn<bar>bd<CR>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" 重载rc文件
nnoremap <leader>sv :exec "source $MYVIMRC"<CR>
" 退出
nnoremap <leader>q :q<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>s :w<CR>

set t_Co=256     "终端开启256色支持"

imap jk <ESC>

colorscheme  sublimemonokai

" Sets how many lines of history VIM has to remember
set history=500

set guifont=Source\ Code\ Pro\ Light:14 " 设置字体和大小
set linespace=5
set encoding=UTF-8
set number
set mouse=a
set selectmode=mouse
syntax enable " 语法高亮
syntax on " 自动语法高亮
set showcmd
set autoindent " 换行后自动缩进
set smartindent " 智能对齐

" 这个在gvim中会自动触发，但是vim中需要一些触发条件，所以调用:checktime是不错的办法
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
set autoread " 文件在外部被修改后 自动重新读取 
" 在vim获取焦点或者进入buffer的时候触发checktime
" 需要下面的插件支持聚焦这个功能,经过尝试插件无效
au CursorHold,CursorHoldI,FocusGained,BufEnter * :checktime

set nocompatible " 不使用compatible模式 

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"Always show current position
set ruler
" 相对行号
" set relativenumber

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

nmap <leader>nh :noh<CR>

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"set foldmethod=syntax   " 基于语法进行折叠
set foldmethod=indent   " 基于缩进进行折叠
"set foldmethod=manual   " 手动建立折叠
"set foldmethod=diff     " 未更改文本构成折叠
set foldnestmax=3
set nofoldenable        " 打开VIM是不折叠代码
"set nowrap " 不换行
set clipboard=unnamed " 使用系统的剪切板
set cursorline " 高亮选中行

" 在iterm中插入模式使用细的光标
"set guicursor=i:ver25-iCursor " 这个不支持自带的vim
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile  " 不允许产生临时文件


set expandtab " 表示tab自动换成空格
function! TabWidth(width)
    let &tabstop=a:width
    let &softtabstop=a:width
    let &shiftwidth=a:width
    set expandtab
    "set cindent
endfunction
call TabWidth(2)
nnoremap <leader>t2 :call TabWidth(2)<CR>
nnoremap <leader>t4 :call TabWidth(4)<CR>


" 重写回车键，如果在包裹的html标签中则增加一个空行
function! Expander()
  let line   = getline(".")
  let col    = col(".")
  let first  = line[col-2]
  let second = line[col-1]
  let third  = line[col]

  if first ==# ">"
    if second ==# "<" && third ==# "/"
      return "\<CR>\<C-o>==\<C-o>O"
    else
      return "\<CR>"
    endif
  else
    return "\<CR>"
  endif
endfunction

inoremap <expr> <CR> Expander()

" 原来的回车 map 到 <C> 回车
inoremap <C><CR> <CR><C-o>==<C-o>O


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


""""""""""""""""""""""""""""""
" => Plug
""""""""""""""""""""""""""""""
" Use vim-plug https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'      " 导航栏插件
Plug 'Xuyuanp/nerdtree-git-plugin' " 导航栏增加git 状态
Plug 'scrooloose/nerdcommenter' " 注释插件
Plug 'https://github.com/pangloss/vim-javascript.git'   " JS plugin
Plug 'https://github.com/mxw/vim-jsx', { 'for': ['javascript.jsx', 'jsx', 'js'] }   " JSX
Plug 'heavenshell/vim-jsdoc' " jsdoc
Plug 'mattn/emmet-vim', { 'for': ['javascript.jsx', 'html', 'css'] } " emmet
" 多行编辑 在iterm上不好用 会卡死 macvim 可以
" Plug 'terryma/vim-multiple-cursors' 
Plug 'Yggdroot/indentLine' " 显示代码缩进
Plug 'SirVer/ultisnips' " 代码片段引擎
Plug 'honza/vim-snippets' " 代码片段
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter' " 开发中展示git的一些状态
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim' " 代替ctrlp
Plug 'w0rp/ale'  " 新的语法检查工具
Plug 'Valloric/YouCompleteMe' " 自动补全插件
Plug 'jiangmiao/auto-pairs' " 自动补全括号
Plug 'dyng/ctrlsf.vim' " 全局搜索插件，需要安装ag
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'elixir-editors/vim-elixir', { 'for': ['elixir', 'eelixir'] } " elixir
Plug 'slashmili/alchemist.vim', { 'for': ['elixir', 'eelixir'] } " elixir
Plug 'godlygeek/tabular' " markdown 插件依赖
Plug 'plasticboy/vim-markdown' 
call plug#end()
" js中也用jsx
let g:jsx_ext_required = 0

" snip 配置
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"


" indentLine 配置
let g:indentLine_char_list = ['|', '¦', '┆', '┊'] " 安层级使用不同的组
let g:indentLine_concealcursor=0 " 高亮的行不显示
autocmd Filetype json let g:indentLine_enabled = 0 " Json 文件不启用 否则会看不到引号

" prettier 配置
nmap <Leader>pt <Plug>(Prettier)
" none|es5|all
let g:prettier#config#trailing_comma = 'none'
" print spaces between brackets
let g:prettier#config#bracket_spacing = 'true'
" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = 'false'

" YCM 配置
"let g:ycm_complete_in_comments = 1 " 注释时仍显示自动补全
" 让vim的补全菜单行为与一般IDE一致
set completeopt=longest,menu
let g:ycm_show_diagnostics_ui = 0 " 不开启诊断，我们用ale诊断
" 遇到下列文件时才会开启YCM
let g:ycm_filetype_whitelist = {
\ "c":1,
\ "cpp":1,
\ "python":1,
\ "sh":1,
\ "jsx": 1,
\ "javascript.jsx": 1,
\ "js": 1,
\ "css": 1,
\ "scss": 1,
\ "less": 1,
\ "elixir": 1
\ }
" css 和 scss 中 如果是开头，并且有多个空格 或者 是: 则触发补全
" html 结尾标签触发补全
let g:ycm_semantic_triggers = {
\   'css': [ 're!^', 're!^\s+', ': ' ],
\   'scss': [ 're!^', 're!^\s+', ': ' ],
\   'html': [ '</' ]
\ }

" 全局搜索 ctrlsf 配置
nmap <leader><C-F> <Plug>CtrlSFPrompt
" 自动聚焦搜索结果窗口
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }

" emmet-vim {{{3
let g:user_emmet_leader_key='<C-E>'
let g:user_emmet_settings = {
  \   'html' : {
  \     'quote_char': "'"
  \   },
  \   'javascript.jsx' : {
  \      'extends': 'jsx',
  \      'quote_char': "'",
  \  }
  \}
" }}3


" NERDTree 配置
let NERDChristmasTree=0
let NERDTreeWinSize=35
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1 " 显示隐藏文件
let NERDTreeWinPos="left"
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif   " 自动关闭导航栏
nmap <leader>kb :NERDTreeToggle<CR>

" airline
" vim-airline {{{3
let g:airline_powerline_fonts = 1 " Enable the patched Powerline fonts

"打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" ale lint 配置
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint']
  \ }
" Set this variable to 1 to fix files when you save them.
" let g:ale_fix_on_save = 1
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)

" fzf 配置
nmap <C-p> :Files<CR>
nmap <C-g> :GFiles<CR>
nmap <silent><leader>h :History<CR>

" 注释插件配置
let g:NERDSpaceDelims = 1 " 注释后自动添加空行
let g:NERDCommentEmptyLines = 1 " 允许注释空行
let g:NERDTrimTrailingWhitespace = 1 " 去掉注释的时候去掉尾部空格

" vim-javascript 配置
let g:javascript_plugin_jsdoc = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

