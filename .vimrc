" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
    "au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    au BufReadPost * exe "normal! g`\""
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
    filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set number              " set number
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" --------------------------------------------------------------------------- "

let mapleader = ","
nnoremap ; :
source $VIMRUNTIME/ftplugin/man.vim " using ':Man' to get help, equivalent to 'K'

" --------------------------------------------------------------------------- "
" colorscheme settings

" tweaks for default console colorscheme
"hi folded ctermbg=black
"hi comment ctermfg=darkgrey
"hi statusline ctermbg=black ctermfg=darkyellow
"hi statuslinenc ctermbg=darkyellow ctermfg=black
" popup menu color tweaks since 7.3.524
"hi pmenu ctermfg=white
"hi pmenusel ctermfg=white

set t_Co=256
"set background=light
"colorscheme solarized
silent colorscheme molokai
hi Todo             ctermfg=black ctermbg=yellow
hi Visual           ctermbg=238
hi StatusLine       ctermfg=64  ctermbg=232
hi StatusLineNC     ctermfg=237 ctermbg=178
hi PmenuSel         ctermfg=253 ctermbg=238
hi Pmenu            ctermfg=81  ctermbg=235
hi MatchParen       ctermfg=18  ctermbg=172
hi LineNr           ctermfg=178 ctermbg=234
hi CursorLine       ctermbg=236

" show trailing spaace(s): http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufEnter,WinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufLeave,WinLeave * call clearmatches()

" auto remove trailing space(s) when :w
autocmd BufWritePre * :%s/\s\+$//e

" --------------------------------------------------------------------------- "
" generic settings. some of them are picked up from debian.vim

set nocp " 'nocompatible': Use Vim defaults instead of 100% vi compatibility
set bs=indent,eol,start	" more powerful backspacing
set hi=50 " keep 50 lines of command line history
set ru " 'ruler': show the cursor position all the time
set nowb " 'nowriteback'
set nobk " 'nobackup'
set noswf " 'noswapfile'
"set nu " 'number': show line number
set nows " 'nowrapscan': searching stops when reaching the end of file
set fdm=syntax " 'foldmethod': fold multi lines by syntax
set fdl=9999 " 'foldlevel': unfold automatically when opening a file
set fencs=utf-8,gbk " 'fileencodings'
set nohls " 'hlsearch': highlight search key
set nomodeline " modelines have historically been a source of security/resource vulnerabilities -- disable by default, even when 'nocompatible' is set
set ar " 'autoread': auto read modified buffer
set wmnu " 'wildmenu': command-line completion
set cot=longest,menuone " 'completeopt': do not show the preview window when omnicompleting
set noinf " 'noinfercase': complete the word as it is

au WinEnter,BufEnter * set cursorline " highlight current line when entering a buffer
au WinLeave,BufLeave * set nocursorline

"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" im auto-switch. available in gvim
"au InsertEnter * set noimdisable
"au InsertLeave * set imdisable

" --------------------------------------------------------------------------- "
" c indent options

set cino=b1,t0,(0,l1,N-s " 'cinoptions': see 'cinoptions-values'
set cink+=0=break " 'cinkeys': for cinoptions
set sw=4 " 'shiftwidth': 4 spaces for indent
set sts=4 " 'softtabstop': delete 4 spaces once
set et " 'expandtab': insert spaces instead of tab
set sta " 'smarttab'

" --------------------------------------------------------------------------- "
" emacs-style key bindings

func! KillLineEnd()
    let l:current_col = col('.')
    let l:row_end = col('$')

    if l:row_end == 1
        normal dd
    else
        if l:current_col == l:row_end - 1
            normal J
            normal a
        else
            normal D
            normal $
        endif
    endif
endfunc

inoremap <C-a> <C-o>^
inoremap <C-b> <left>
inoremap <C-d> <del>
inoremap <C-e> <end>
inoremap <C-f> <right>
inoremap <C-k> <C-o>:call KillLineEnd()<cr>
inoremap <C-n> <down>
inoremap <C-p> <up>
inoremap <C-y> <esc>pa

" --------------------------------------------------------------------------- "
" buffer shortcuts

nnoremap <C-x>b :b#<cr>
inoremap <C-x>b <C-o>:b#<cr>
nnoremap <C-x><C-b> :BufExplorer<cr>
inoremap <C-x><C-b> <esc>:BufExplorer<cr>

nnoremap <silent> <C-n> :bn<cr>
nnoremap <silent> <C-p> :bp<cr>

func! KillBuffer()
    let l:curr_buf = bufnr("%")
    let l:prev_buf = bufnr("#")

    if buflisted(l:prev_buf)
        bprev
    else
        bnext
    endif

    if bufnr("%") == l:curr_buf
        new
    endif

    exec "bwipe " . l:curr_buf
endfunc

nnoremap <silent> <C-x>k :call KillBuffer()<cr>

" --------------------------------------------------------------------------- "
" window shortcuts

nnoremap <tab> <C-w>w
nnoremap <C-left> <C-w><
nnoremap <C-right> <C-w>>
nnoremap <C-up> <C-w>+
nnoremap <C-down> <C-w>-
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" --------------------------------------------------------------------------- "
" cscope settings

func! LoadCscope()
    if has("cscope")
        set cscopeprg=/usr/bin/cscope
        set cscopetagorder=0
        set cscopetag

        let s:currdir = getcwd()
        while !filereadable("cscope.out")
            if getcwd() == "/"
                break
            endif
            cd ..
        endwhile
        if filereadable("cscope.out")
            cs add cscope.out
        else
            cd `=s:currdir` " cd %:p:h or :set acd
        endif
    endif
endfunc

call LoadCscope()

set cst " 'cscopetag': search cscope database first, then tags if not found

" --------------------------------------------------------------------------- "
" ctags settings

set tags=tags; " see 'file-searching'

" --------------------------------------------------------------------------- "
" development shortcuts

"nnoremap <F2> :DiffOrig<cr>
"inoremap <F2> <esc>:DiffOrig<cr>
nnoremap <silent> <F3> :NERDTreeToggle<cr>
inoremap <silent> <F3> <esc>:NERDTreeToggle<cr>
nnoremap <silent> <F4> :TagbarToggle<cr>
inoremap <silent> <F4> <esc>:TagbarToggle<cr>
nnoremap <F5> :wa<cr>:!run %<cr>
inoremap <F5> <esc>:wa<cr>:!run %<cr>a
"nnoremap <F7> :make clean && make<cr><cr><cr>
"inoremap <F7> <C-o>:make clean && make<cr><cr><cr>
nnoremap <F9> :!cscope -Rbkq<cr>:cs reset<cr>:!ctags -R --c++-kinds=+dx --fields=+aiS --extra=+q<cr>:set tags=/usr/include/tags,tags;<cr>

" --------------------------------------------------------------------------- "
" statusline settings

set statusline=%f\ %r\ %m%=row:\ %l\ \ \ col:\ %c%V " 'statusline'

" --------------------------------------------------------------------------- "
" misc settings

" `stty -ixon' to disable ctrl-s and ctrl-q in bash
nnoremap <C-s> :w<cr>
inoremap <C-s> <C-o>:w<cr>
nnoremap <C-q> :q<cr>
inoremap <C-q> <esc>:q<cr>

nnoremap <space> o<esc>0D
inoremap <C-\> <left><cr><up><end><cr>

" <cr> action according to whether there is a popup menu
inoremap <expr> <cr> pumvisible()?"\<C-y>":"\<cr>"

" user-defined keyword highlighting
"autocmd filetype c,cpp,h syn keyword MyType atomic_t | hi link MyType type

" autoload plugins according to filetype
"autocmd vimEnter *.c,*.cpp,*.h :NERDTree | :wincmd l

if filereadable(".project.vim")
    source .project.vim
endif

let php_folding = 2

" --------------------------------------------------------------------------- "
" do not indent c++ templates

function! CppTemplateIndentation()
    let l:cline_num = line('.')
    let l:cline = getline(l:cline_num)

    let l:pline_num = prevnonblank(l:cline_num - 1)
    let l:pline = getline(l:pline_num)
    while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
        let l:pline_num = prevnonblank(l:pline_num - 1)
        let l:pline = getline(l:pline_num)
    endwhile

    let l:retv = cindent('.')
    let l:pindent = indent(l:pline_num)
    if l:pline =~# '^\s*template<typename\s*.*>\s*$'
        let l:retv = l:pindent
    elseif l:pline =~# '^\s*template<class\s*.*>\s*$'
        let l:retv = l:pindent
    endif
    return l:retv
endfunction

au BufEnter,WinEnter *.{cc,cpp,h,hpp} setlocal indentexpr=CppTemplateIndentation()

" --------------------------------------------------------------------------- "
" bufexplorer settings

let g:bufExplorerFindActive = 0

" --------------------------------------------------------------------------- "
" nerdtree settings

let g:NERDTreeIgnore = ['\.orig$', '\.o$', '\.a$', '\.so$', '\.log$', '^cscope', 'tags', 'core', 'a.out']
let g:NERDTreeWinSize = 24

" --------------------------------------------------------------------------- "
" neocomplcache settings

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1

let g:neocomplete#max_list = 25

let g:neocomplete#enable_fuzzy_completion = 1

let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" --------------------------------------------------------------------------- "
" tagbar settings

let g:tagbar_width = 24

" --------------------------------------------------------------------------- "
" ms-windows settings

"autocmd vimEnter * simalt ~x " maximize when launched
"set guicursor=a:block-blinkoff0

"set guifont=Dejavu\ Sans\ Mono:h12
"set guioptions-=T " toolbar
"set guioptions-=m " menubar
"set guioptions-=l " same as 'r'
"set guioptions-=L " same as 'R'
"set guioptions-=r " right-hand scrollbar always
"set guioptions-=R " right-hand scrollbar is presented when is a vsplit window
"set guioptions-=b " bottom scrollbar
