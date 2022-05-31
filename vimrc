" This is standard pathogen and vim setup
set nocompatible

" Load plugins from .vim/bundles using .vim/autoload/pathogen.vim
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

call pathogen#infect()

set t_Co=256
colo desertEx

" http://askubuntu.com/questions/125526/vim-in-tmux-display-wrong-colors
set term=screen-256color

" Make vim better and faster
set ttymouse=xterm2
set ttyfast

" Step #1: No beeping or flashing!
set noeb vb t_vb=

" Step #2: change local leader
let maplocalleader = ","

" Step #3: Disable annoying help
imap <F1> <Esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Saved macros - http://stackoverflow.com/questions/2024443/saving-vim-macros
let @c='"+y' " Capitalize first leter and jump to next word.
let @v='"+gp'      " or maybe one day map Ctrl-Shift-P if possible?

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other GUI-vs-console-specific customizations

if has("gui_running")
  inoremap <C-Space> <C-P>
else
  inoremap <Nul> <C-P>

  " also, make the cursor to bar when in insert mode
  if has("autocmd")
    au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
    au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
  endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs and Spaces
" http://vimcasts.org/episodes/tabs-and-spaces/
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FileTypes and language-specific features
filetype plugin indent on
syntax on

" http://stackoverflow.com/questions/158968/changing-vim-indentation-behavior-by-file-type
autocmd FileType           html,xml,clj,ruby,js,py setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType           scala,sc          setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType           c,h,java          setlocal expandtab
autocmd FileType           make,txt          setlocal noexpandtab
autocmd FileType           jade              setlocal noexpandtab
autocmd BufRead,BufNewFile *.md              setlocal expandtab sw=2 ts=2 sts=2

" turn off autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-dispatch
nnoremap <F8> :Dispatch<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clojure / TMUX
" https://github.com/dgrnbrg/vim-redl/issues/24#issuecomment-50822711
imap <silent> <C-S-K> <Plug>clj_repl_uphist.
imap <silent> <C-S-J> <Plug>clj_repl_downhist.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby
autocmd FileType	ruby	setlocal makeprg=ruby\ %
autocmd FileType	ruby	let b:vimpipe_command="ruby"
map <LocalLeader>r :call VimuxRunCommand("clear; ruby " . bufname("%"))<CR>
map <LocalLeader>i :call VimuxRunCommand("irb")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CoffeeTags
" let g:CoffeeAutoTagDisabled=<0 or 1>     " Disables autotaging on save (Default: 0 [false])
" let g:CoffeeAutoTagFile=tags       " Name of the generated tag file (Default: ./tags)
" let g:CoffeeAutoTagIncludeVars=<0 or 1>  " Includes variables (Default: 0 [false])
" let g:CoffeeAutoTagTagRelative=<0 or 1>  " Sets file names to the relative path from the tag file location to the tag file location (Default: 1 [true])

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python
autocmd FileType	python	setlocal makeprg=python\ %
autocmd FileType	python	let b:vimpipe_command="python"
map <LocalLeader>r :call VimuxRunCommand("clear; python " . bufname("%"))<CR>
map <LocalLeader>i :call VimuxRunCommand("python")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scala Console
map <LocalLeader>sc :call VimuxRunCommand("clear; scala")<CR>

" workaround for https://github.com/mdreves/vim-scaladoc/issues/1
fun! OpenScalaDoc( arg )
  call scaladoc#Search(a:arg)
endf
command! -nargs=+ ScalaDoc call OpenScalaDoc('<f-args>')
autocmd FileType scala nnoremap K :call OpenScalaDoc(expand("<cword>"))<CR>
autocmd FileType scala let b:dispatch = 'sbt test'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Node Console
map <LocalLeader>no :call VimuxRunCommand("clear; node")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Various standard vim settings

" Make the mouse work
set mouse=a

set hidden
set number
set incsearch
set hlsearch
set ignorecase
set smartcase

" Popup suggestions for the command buffer.
set wildmenu
set wildignore=*.swp,*.class,.git,*.pyc,*/target/*,*/node_modules/*

" Enable autoindent, cindent
" http://blogs.gnome.org/johannes/2006/11/10/getting-cool-auto-indent-in-vim/
set cindent
set smartindent
set autoindent

" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
set nowrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0
set formatoptions+=l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quick Navigation
" Rempap keys for window navigation
" http://vimcasts.org/episodes/working-with-windows/
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" quickly navigate buffers #protip
nnoremap gb :ls<CR>:b<Space>

" ctags
set tags=tags;/
" no binary search for tags :(
set notbs

" nmap <F9> :TagbarToggle<CR>

" http://www.vimbits.com/bits/145
" Ctrl-L recolors the screen when it gets confused.
" noremap <c-a> <c-a>:syntax sync fromstart<CR>
" noremap <c-a> <esc><c-a>:syntax sync fromstart<CR>a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TMUX
" make arrow keys work in tmux console vim
" http://stackoverflow.com/questions/8813855/in-vim-how-can-i-make-esc-and-arrow-keys-work-in-insert-mode
if has("gui_running")
 " do nothing
else
  set esckeys
  set ttimeoutlen=10
  inoremap A <Up>
  inoremap B <Down>
  inoremap C <Right>
  inoremap D <Left>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimux
" Prompt for a command to run map
map <LocalLeader>vp :VimuxPromptCommand<CR>

" Inspect runner pane
map <LocalLeader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <LocalLeader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
map <LocalLeader>vx :VimuxInterruptRunner<CR>

function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction

" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <LocalLeader>vs "vy :call VimuxSlime()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
" Start NERDTree but put focus on main window
" autocmd VimEnter * NERDTree | wincmd p
" autocmd VimEnter * vertical resize +10
" :NT opens NerdTree
fun! OpenNERDTree()
  execute ":NERDTree"
endf
command! NT call OpenNERDTree()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer Delete
noremap <LocalLeader>q :Bdelete<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-T
noremap <LocalLeader>t :CommandT<CR>
noremap <LocalLeader>b :CommandTBuffer<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack-Grep
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto completion!

" http://vim.wikia.com/wiki/VimTip1386
" "Make vim popup work just like in an IDE"
set completeopt+=longest,menuone

" Customizing ins-completion / omni completion
" http://vim.wikia.com/wiki/Omni_completion
" http://vim.wikia.com/wiki/Omni_completion_popup_menu
" http://vim.wikia.com/wiki/Improve_completion_popup_menu
set omnifunc=syntaxcomplete#Complete

inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

" For some reason the below don't work in console vim...
" Just use C-N and C-P!!!
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Import local .vimrc
source $HOME/.local.vimrc

