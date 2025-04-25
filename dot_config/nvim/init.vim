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
	Plug 'ajmwagar/vim-deus'
	Plug 'airblade/vim-gitgutter'
	Plug 'wincent/terminus'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'ryanoasis/vim-devicons'
	Plug 'mhinz/vim-startify'
	Plug 'scrooloose/nerdtree'
	Plug 'neomake/neomake'
	Plug 'tpope/vim-fugitive'
	Plug 'dart-lang/dart-vim-plugin'
	Plug 'sbdchd/neoformat'
	Plug 'dhruvasagar/vim-table-mode'
call plug#end()

let g:NERDTreeMinimalUI = 1
let NERDTreeHijackNetrw = 1
autocmd User StartifyBufferOpened :NERDTree | :wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
			\ && b:NERDTree.isTabTree()) | q | endif

let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

if $TERM!='linux'
	unl g:airline_symbols_ascii
	set termguicolors
	colorscheme deus
	let g:airline_theme='deus'
	let g:airline_powerline_fonts = 1
endif

set relativenumber
set number

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
nnoremap <M-f> :Neoformat<CR>
nnoremap <M-n> :set relativenumber!<CR>:set number!<CR>

nnoremap <C-M-Left> :tabprevious<CR>
nnoremap <C-M-Right> :tabnext<CR>
nnoremap <M-Left> :bp<CR>
nnoremap <M-Right> :bn<CR>

" keep the default clipboard-tool for everything else
if !empty($SSH_TTY)
	let g:clipboard = 'osc52'
endif

set clipboard+=unnamedplus
set colorcolumn=+0
set textwidth=80
set path+=**

" set pylint preferred width
autocmd FileType python set textwidth=100
autocmd FileType rst set tabstop=3 shiftwidth=3 expandtab
autocmd FileType dart set tabstop=2 shiftwidth=2 expandtab
autocmd FileType json,jsonc set tabstop=2 shiftwidth=2 expandtab
