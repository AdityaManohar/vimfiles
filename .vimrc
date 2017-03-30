set nocompatible              " be iMproved, required
set encoding=utf-8
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'myusuf3/numbers.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/syntastic'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'
Plugin 'chase/vim-ansible-yaml'
Plugin 'othree/html5.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'kchmck/vim-coffee-script'
Plugin 'jiangmiao/auto-pairs'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'scrooloose/nerdtree'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'elzr/vim-json'
Plugin 'digitaltoad/vim-jade'
Plugin 'octol/vim-cpp-enhanced-highlight'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

setlocal foldmethod=indent

" Numbers fix for v7.4
set number

" Backspace fix for v7.4
set backspace=2

" Fugitive vertical diff
set diffopt+=vertical

" Colors
syntax on
set background=dark
colorscheme atom-dark-256

" Tabstops and indenting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase
:command! C let @/=""

" Remap keys
imap jj <Esc>
nmap cc :SyntasticToggleMode<CR><ESC>
nmap ss :NERDTreeToggle<CR><ESC>
imap <C-n> :NumbersToggle<CR>

" Hightlight Cursor
set cursorline

" Clipboard access
set clipboard=unnamed

" Mouse control
set mouse=a

" Lightline
set laststatus=2
let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'fugitive', 'filename' ]],
            \ },
            \ 'component_function': {
            \   'fugitive': 'MyFugitive',
            \   'readonly': 'MyReadonly',
            \   'modified': 'MyModified',
            \   'filename': 'MyFilename'
            \ }
            \ }

function! MyModified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction

function! MyReadonly()
    if &filetype == "help"
        return ""
    elseif &readonly
        return "\ue0a2"
    else
        return ""
    endif
endfunction

function! MyFugitive()
    if exists("*fugitive#head")
        let _ = fugitive#head()
        return strlen(_) ? "\ue0a0 "._ : ""
    endif
    return ''
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ ('' != expand('%') ? expand('%') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_wq=1
let g:syntastic_error_symbol="\u2718"
let g:syntastic_warning_symbol="\u26A0"
let g:syntastic_style_error_symbol="\u2718"
let g:syntastic_style_warning_symbol="\u26A0"
let g:syntastic_stl_format='[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_javascript_checkers=["eslint"]
"let g:syntastic_javascript_eslint_args="--no-eslintrc --config ~/.eslintrc"
let g:syntastic_html_checkers=["validator"]
let g:syntastic_yaml_checkers=["js-yaml"]


" Custom file types
au BufNewFile,BufRead *.jst set filetype=html
au BufNewFile,BufRead *.jsx set filetype=javascript
au BufNewFile,BufRead *.feature,*.story set filetype=cucumber
