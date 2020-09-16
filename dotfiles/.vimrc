" Author: Theerawat Kiatdarakun
" I group all codes by scopes
" Scope: Local Variable
" Scope: Character
" Scope: Word
" Scope: Line
" Scope: Visual Select
" Scope: All Text in File
" Scope: File
" Scope: Configuration
" Scope: Plugin
" ========================================
"                    Scope: Local Variable
" ========================================
let s:char_html_escape={
	\'&': '&amp;',
	\">": "&gt;",
	\'<': '&lt;'
\}
let s:char_closing_braces=['{}','()','[]']
let s:char_surround_insertmode=s:char_closing_braces + ['""', "''"]
let s:char_surround=s:char_surround_insertmode + ['**','<>']
let s:commentgroup=[
	\{
		\'comment-symbol': '#',
		\'ext': '*.bash,*.gitignore,*.py,*.sh,*.tf,*.tmux.conf,*.yml,*.zprofile,*.zshenv,*.zshrc',
		\'comment-line': 'mqI# <esc>`qll',
		\'comment-visual': ':s/^\%V/# /g<cr>:nohl<cr>',
		\'uncomment-line': 'mqI<del><del><esc>`qhh',
		\'uncomment-visual': ':s/^\%V# //g<cr>'
	\},
	\{
		\'comment-symbol': '//',
		\'ext': '*.adoc,*.go,*.h,*.js,*.cpp',
		\'comment-line': 'mqI// <esc>`qll',
		\'comment-visual': ':s/^\%V/\/\/ /g<cr>:nohl<cr>',
		\'uncomment-line': 'mqI<del><del><del><esc>`qhh',
		\'uncomment-visual': ':s/^\%V\/\/ //g<cr>'
	\},
	\{
		\'comment-symbol': '/* */',
		\'ext': '*.css,*.scss',
		\'comment-line': 'mqI/*<esc>A*/<esc>`qll',
		\'comment-visual': ':s/^/\/*/g<cr>gv:s/$/*\//g<cr>:nohl<cr>',
		\'uncomment-line': 'mqI<del><del><esc>A<bs><bs><esc>`qhh',
		\'uncomment-visual': ':s/\/\*//g<cr>gv:s/\*\///g<cr>:nohl<cr>'
	\},
	\{
		\'comment-symbol': '"',
		\'ext': '*.vim,*.vimrc,',
		\'comment-line': 'mqI" <esc>`qll',
		\'comment-visual': ':s/^\%V/" /g<cr>:nohl<cr>',
		\'uncomment-line': 'mqI<del><del><esc>`qhh',
		\'uncomment-visual': ':s/^\%V" //g<cr>'
	\},
	\{
		\'comment-symbol': '<!-- -->',
		\'ext': '*.html',
		\'comment-line': 'mqI<!--<esc>A--><esc>`qllll',
		\'comment-visual': ':s/^/<!--/g<cr>gv:s/$/-->/g<cr>:nohl<cr>',
		\'uncomment-line': 'mqI<del><del><del><del><esc>A<bs><bs><bs><esc>`qhhhh',
		\'uncomment-visual': ':s/<!--//g<cr>gv:s/-->//g<cr>:nohl<cr>'
	\}
\]
let mapleader=','
let space_per_tab=2
let template_dir='~/.vim/template/'
" ========================================
"                         Scope: Character
" ========================================
for val in s:char_closing_braces
	exe 'inoremap '.val[0].'<CR> '.val[0].'<CR>'.val[1].'<Esc>ko<tab>'
endfor
for val in s:char_surround_insertmode
	exe 'inoremap '.val[0].' '.val[0].val[1].'<Esc>i'
endfor
" ========================================
"                              Scope: Word
" ========================================
" html escape
for [key, val] in items(s:char_html_escape)
	exe 'inoremap '.key.'esc '.val
endfor
" enclose word under cursor by symbols
for val in s:char_surround
	exe 'nnoremap <leader>'.val[0].' ciw'.val[0].val[1].'<esc>Pl'
endfor
" delete enclose char
nnoremap <leader>d mqdiwpbXX`qh
" abbreviation
inoreabbrev shebang #!/usr/bin/env
inoreabbrev bestregards <bs><cr><cr>Best regards,<cr>Theerawat Kiatdarakun
inoreabbrev lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. In dapibus convallis massa, nec gravida diam pellentesque at. Aliquam mollis tempor mi sed venenatis. Maecenas neque massa, pulvinar vitae lacus et, convallis interdum ligula. Suspendisse rhoncus a arcu quis volutpat. Donec ac risus eros. Pellentesque convallis lectus eu sodales ornare. Quisque egestas ex non purus porta porttitor. Ut blandit feugiat iaculis. Nulla mollis venenatis pulvinar. Nullam pulvinar efficitur aliquet. Donec in nibh eleifend, finibus dui nec, faucibus dui.
" template
exe 'nnoremap <leader>html5 <ESC>:r '.template_dir.'html5.template<CR>kdd/body<CR>:nohl<CR>o'
exe 'nnoremap <leader>vue <ESC>:r '.template_dir.'vue.template<CR>kdd'
exe 'nnoremap <leader>gomain <ESC>:r '.template_dir.'main.go.template<CR>kddjjjjjjA'
exe 'nnoremap <leader>gotest <ESC>:r '.template_dir.'main_test.go.template<CR>kddjjjjjjeea'
" ========================================
"                              Scope: Line
" ========================================
" comment and uncomment
for i in range(0,4)
	exe ':autocmd BufNewFile,BufRead '.s:commentgroup[i]['ext'].' nnoremap <buffer> <leader>c '.s:commentgroup[i]['comment-line']
	exe ':autocmd BufNewFile,BufRead '.s:commentgroup[i]['ext'].' nnoremap <buffer> <leader>u '.s:commentgroup[i]['uncomment-line']
endfor
" insert at the end of current line
nnoremap <leader>, mqA,<esc>`q
nnoremap <leader>; mqA;<esc>`q
" delete last character
nnoremap <leader>a mq$x<esc>`q
" insert line above/below
nnoremap <leader>O mqO<esc>`q
nnoremap <leader>o mqo<esc>`q
" ========================================
"                     Scope: Visual Select
" ========================================
" surround visual select with characters
for val in s:char_surround
	exe 'vnoremap <leader>'.val[0].' mq:s/\%V.*\%V./'.val[0].'&'.val[1].'/<cr>`qf'.val[1].':nohl<cr>'
	if val[0] !=# val[1]
		exe 'vnoremap <leader>'.val[1].' mq:s/\%V.*\%V./'.val[0].'&'.val[1].'/<cr>`qf'.val[1].':nohl<cr>'
	endif
endfor
" map 2 tabs to 1 tab
vnoremap <leader><tab><tab> :s/\%V\t\t/\t/g<cr>:nohl<cr>
" comment and uncomment
for i in range(0,4)
	exe ':autocmd BufNewFile,BufRead '.s:commentgroup[i]['ext'].' vnoremap <buffer> <leader>c '.s:commentgroup[i]['comment-visual']
	exe ':autocmd BufNewFile,BufRead '.s:commentgroup[i]['ext'].' vnoremap <buffer> <leader>u '.s:commentgroup[i]['uncomment-visual']
endfor
" search and replace global
vnoremap <leader>R y:%s/<c-r>"//g<left><left>
" ========================================
"                  Scope: All Text in File
" ========================================
" colorscheme
colorscheme tkiatd
" clear last search pattern
let @/ = ""
" search current word
nnoremap <leader>/ viw"qy/<C-r>q<cr>N
" replace current word
nnoremap <leader>R viw"qy:%s/<C-r>q//g<left><left>
" replace spaces at beginning with tab(s)
exe 'nnoremap <leader><tab> mq:%s/\(^ *\)\@<= \{'.space_per_tab.'\}/<tab>/g<cr>`q'
" strip trailing whitespace
nnoremap <leader>ss mq:%s/\s\+$//<cr>`q
" toggle highlight
nnoremap <expr> <leader>hl (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
" ========================================
"                              Scope: File
" ========================================
" asciidoctor autoconvert after save, note! must open file directly like vim <filename>, not vim .
let s:asciidoctor_stylesdir='/home/tkiatd/Git/assets/stylesheets/asciidoctor-skins/'
function AsciiDocToHTML()
	execute '!asciidoctor -a stylesdir='.s:asciidoctor_stylesdir.' '.expand('%:t')
	execute '!html-minifier --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --use-short-doctype --minify-css true --minify-js true -o '.expand('%:r').'.html '.expand('%:r').'.html'
endfunction
autocmd BufWritePost *.adoc :call AsciiDocToHTML()
" save file
nnoremap <leader>s :update<cr>
vnoremap <leader>s <c-c>:update<cr>
" open file
nnoremap <leader>oc :vsplit ~/.vim/colors/tkiatd.vim<cr>
nnoremap <leader>ov :vsplit $MYVIMRC<cr>
nnoremap <leader>ozc :vsplit ~/.zshrc<cr>
nnoremap <leader>oze :vsplit ~/.zshenv<cr>
nnoremap <leader>ozp :vsplit ~/.zprofile<cr>
" source file
nnoremap <leader>sv :source $MYVIMRC<cr>
" netrw
let g:netrw_browse_split = 3 " open file in new tab
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro nornu' " enable line number
let g:netrw_liststyle = 3 " tree listing style"
" disable scratch preview
set completeopt-=preview
" ========================================
"               Scope: Configs and Plugins
" ========================================
" Set
set autoindent " auto indent next line
set cursorline " highlight current line
set foldmethod=indent
set hlsearch " highlight searches
set incsearch " highlight while still typing search
set list " enable listchars
set listchars=eol:$,tab:\|·,trail:_
set nofoldenable " disable auto-folding at start
set number " show line number
set pumheight=10 " Pmenu max height
exe 'set shiftwidth='.space_per_tab
exe 'set tabstop='.space_per_tab
" move new tab to the last position
autocmd BufNew * execute ":tabm"
" config: directories ====================
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
" ----------------------------------------
" pkg manager: vim-pathogen ==============
call pathogen#infect()
" ----------------------------------------
" plugin: NERDTree =======================
filetype plugin indent on
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" ----------------------------------------
" plugin: vim-go =========================
nnoremap <leader>gi :GoImport <C-R><C-W><cr>
" ----------------------------------------
" plugin: vim-terraform ==================
let g:terraform_fmt_on_save=1
" ----------------------------------------
