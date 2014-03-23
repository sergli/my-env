set nocompatible	" be iMproved
filetype off		" required !

set history=256

set noautowrite
set noautoread

set timeoutlen=500		" Time to wait after ESC (default causes an annoying delay)

set tags=./tags;$HOME	" walk directory tree upto $HOME looking for tags

" Modeline
set modeline
set modelines=5			" default numbers of lines to read for modeline instructions

" Backup
set nowritebackup
set nobackup
set directory=/tmp//	" prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
set noswapfile

" Match and search
set hlsearch	" highlight search
set ignorecase	" Do case in sensitive matching with
set smartcase	" be sensitive when there's a capital letter
"set incsearch  

" Formatting "
set fo+=o " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r " Do not automatically insert a comment leader after an enter
set fo-=t " Do no auto-wrap text using textwidth (does not apply to comments)

"autocmd BufNewFile,BufRead * setlocal formatoptions+=tcqn

"set nowrap
set textwidth=0	"Don't wrap lines by default
set wildmode=longest,list

set backspace=indent,eol,start	" more powerfull backspace

set showmatch		" Show matching brackets
set matchtime=5		" Bracket blinking
set novisualbell
set noerrorbells
set ruler			" Show ruler
set showcmd 		" Display an incomplete command in the lower right corner of the Vim window
set shortmess=atI 	" Shortens messages


set splitbelow	"	Новое окно откроется снизу и фокус будет на нём
set splitright


set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set noexpandtab
set number
set fencs=utf8,cp1251,latin1,default
set listchars=eol:↲,tab:→→,trail:·,nbsp:↔

colorscheme evening
set background=dark
"highlight Folded ctermbg=255 ctermfg=216
highlight Folded ctermbg=255 ctermfg=darkred
highlight IncSearch ctermbg=green ctermfg=darkred


"Статусная строка
set laststatus=2   " всегда показывать строку статуса
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]


set wildmenu
set wildmode=longest,full
set wildignore+=*.o,*/.git/*,*/.hg/*,*/.svn/*


nmap <F2> :!php -l %<CR>
nmap <F3> :!ctags -R<CR>

"	Выделенное заключать в теги / кавычки
vnoremap  s<b></b>hhhgP
vnoremap  s""gPa	

"Выделяем текст, потом ищем его
vnoremap <C-r> "hy/<C-r>h


" Easily modify vimrc
nmap <leader>v :e $MYVIMRC<CR>
" Apply vim configurations without restarting
if has("autocmd")
    augroup myvimrchooks
        au!
        autocmd BufWritePost .vimrc source ~/.vimrc
    augroup END
endif



" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
cmap w!! %!sudo tee > /dev/null %

" Далее отсюда: https://github.com/bio/dotfiles

" Automatically remove trailing whitespace
autocmd BufWritePre *.php,*.py,*.css,*.js,*.md,*.txt :call Preserve("%s/\\s\\+$//e")

" Preserves the state
function! Preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Strip trailing whitespaces
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
vmap _$ :call Preserve("s/\\s\\+$//e")<CR>

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif " restore position in file

" Перед сохранением вырезаем пробелы на концах
autocmd BufWritePre *.csv m:%s/\s\+$//e

" По табу - фокус на другой сплит
" nnoremap <Tab> <C-w>w

"set foldenable			" Turn on folding
"set foldmethod=marker	" Fold on the marker
"set foldlevel=100		" Don't autofold anything (but I can still fold manually)
"set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds 

set foldenable
set foldmethod=syntax
set foldcolumn=2
set foldminlines=8




set runtimepath+=~/.vim/bundle/vundle/
" Plugins 
call vundle#rc()

"Bundle 'scrooloose/syntastic'


" let Vudnle manage Vundle
" required !
Bundle 'gmarik/vundle'

Bundle 'vim-scripts/bufkill.vim'
	cnoremap bw BW

Bundle 'joonty/vdebug'
	let g:vdebug_options = {'server':	'0.0.0.0'}

Bundle 'tobyS/vmustache'

"Bundle 'SirVer/ultisnips'

"Bundle 'mustache/vim-mode'
"	let g:mustache_abbrebiations = 1

"Bundle 'tobyS/pdv'
"	let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates"
"	nnoremap <buffer> <C-p> :call pdv#DocumentCurrentLine()<CR>

"	let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
"	nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

Bundle 'sumpygump/php-documentor-vim'
"	Old version
	 au BufRead,BufNewFile *.php inoremap <buffer> <C-P> :call PhpDocSingle()<CR>
	 au BufRead,BufNewFile *.php nnoremap <buffer> <C-P> :call PhpDocSingle()<CR>
	 au BufRead,BufNewFile *.php vnoremap <buffer> <C-P> :call PhpDocRange()<CR>
	let g:pdv_cfg_Package = ''
	let g:pdv_cfg_Author = 'Sergey Lisenkov <sergli@nigma.ru>'


Bundle 'evanmiller/nginx-vim-syntax'

Bundle 'StanAngeloff/php.vim'
	" Виды комментов в php
	autocmd FileType php set comments=s1:/*,mb:*,ex:*/,://,:#
	let g:php_sql_query=2
	let g:php_html_in_strings=1
	" 1 - только функции, 2 - все пары {}
	let g:php_folding=1

Bundle 'scrooloose/nerdtree'
	let NERDTreeShowHidden=1
	nmap <C-N>v :NERDTree<cr>
	vmap <C-N>v <esc>:NERDTree<cr>i
	imap <C-N>v <esc>:NERDTree<cr>i

	nmap <C-N>x :NERDTreeClose<cr>
	vmap <C-N>x <esc>:NERDTreeClose<cr>i
	imap <C-N>x <esc>:NERDTreeClose<cr>i

Bundle 'fholgado/minibufexpl.vim'
	let g:miniBufExplShowBufNumbers=0
	let g:miniBufExplBRSplit = 0
	" По стелочкам влево/вправо перемещаемся по 
	" наиболее часто используемым (fixme?) буферам
	nnoremap [1;5D :MBEbp
	nnoremap [1;5C :MBEbn

"Bundle 'noahfrederick/vim-noctu'

Bundle '2072/PHP-Indenting-for-VIm'

" По табу - фокус на другой сплит
nnoremap <Tab> <C-w>w


filetype on
filetype plugin indent on	" required!
syntax on;

set scrolloff=20

set pastetoggle=<F12>
