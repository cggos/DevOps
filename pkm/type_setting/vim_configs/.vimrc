set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'easymotion/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'valloric/youcompleteme'
" Plugin 'brookhong/cscope.vim'
"" install nodejs and instant-markdown-d before installing the plugin
" Plugin 'suan/vim-instant-markdown'

call vundle#end()            " required

filetype plugin indent on    " required

let mapleader = ","

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_key_invoke_completion = '<C-a>'
" let g:ycm_show_diagnostics_ui = 0
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:airline#extensions#tabline#enabled = 1

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1

let g:NERDSpaceDelims = 1

let g:DoxygenToolkit_briefTag_funcName = "yes"
let g:DoxygenToolkit_authorName = "GaoHongchen, cggos@outlook.com"
let g:doxygen_enhanced_color = 1

set tags=./tags,./TAGS,tags;~,TAGS;~

" set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:»,precedes:«,space:.
" set list

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set hlsearch

" set nu
set relativenumber

" set cursorline

set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,gbk,latin1
