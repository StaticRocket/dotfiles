let g:startify_custom_header = [
\ '   ::::    ::: ::::::::::  ::::::::  :::     ::: ::::::::::: ::::    :::: ',
\ '   :+:+:   :+: :+:        :+:    :+: :+:     :+:     :+:     +:+:+: :+:+:+',
\ '   :+:+:+  +:+ +:+        +:+    +:+ +:+     +:+     +:+     +:+ +:+:+ +:+',
\ '   +#+ +:+ +#+ +#++:++#   +#+    +:+ +#+     +:+     +#+     +#+  +:+  +#+',
\ '   +#+  +#+#+# +#+        +#+    +#+  +#+   +#+      +#+     +#+       +#+',
\ '   #+#   #+#+# #+#        #+#    #+#   #+#+#+#       #+#     #+#       #+#',
\ '   ###    #### ##########  ########      ###     ########### ###       ###',
\ ]

call plug#begin()
	Plug 'chriskempson/base16-vim'
	Plug 'chrisbra/SudoEdit.vim'
	Plug 'airblade/vim-gitgutter'
	Plug 'wincent/terminus'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'zefei/vim-wintabs'
	Plug 'zefei/vim-wintabs-powerline'
	Plug 'ryanoasis/vim-devicons'
	Plug 'mhinz/vim-startify'
	Plug 'scrooloose/nerdtree'
	Plug 'neomake/neomake'
	Plug 'tpope/vim-fugitive'
	Plug 'dart-lang/dart-vim-plugin'
	Plug 'sbdchd/neoformat'
call plug#end()

let g:NERDTreeMinimalUI = 1
let NERDTreeHijackNetrw = 1
autocmd User StartifyBufferOpened :NERDTree | :wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
			\ && b:NERDTree.isTabTree()) | q | endif

if $TERM!='linux'
	set termguicolors
	colorscheme base16-oceanicnext
	let g:airline_theme='base16_oceanicnext'
	let g:airline_powerline_fonts = 1
endif

set relativenumber

call neomake#configure#automake('nrwi', 500)

tnoremap <M-Left> <C-\><C-N><C-w>h
tnoremap <M-Down> <C-\><C-N><C-w>j
tnoremap <M-Up> <C-\><C-N><C-w>k
tnoremap <M-Right> <C-\><C-N><C-w>l
inoremap <M-Left> <C-\><C-N><C-w>h
inoremap <M-Down> <C-\><C-N><C-w>j
inoremap <M-Up> <C-\><C-N><C-w>k
inoremap <M-Right> <C-\><C-N><C-w>l
nnoremap <M-Left> <C-w>h
nnoremap <M-Down> <C-w>j
nnoremap <M-Up> <C-w>k
nnoremap <M-Right> <C-w>l

nnoremap <M-s> :setlocal spell!<CR>
nnoremap <M-t> :NERDTreeToggle<CR>

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

set clipboard+=unnamedplus
set colorcolumn=80
set path+=**
