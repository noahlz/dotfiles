" Load plugins from .vim/bundles using .vim/autoload/pathogen.vim
call pathogen#incubate()
call pathogen#helptags()

" This is standard pathogen and vim setup
set nocompatible
call pathogen#infect() 

filetype plugin indent on
syntax on
" http://vimcasts.org/episodes/tabs-and-spaces/
set shiftwidth=4 
set tabstop=4 
set softtabstop=4
set noexpandtab
" http://stackoverflow.com/questions/158968/changing-vim-indentation-behavior-by-file-type
autocmd FileType           html,xml,clj,ruby   setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufRead,BufNewFile *.md                setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType           c,h,java            setlocal expandtab
autocmd FileType           make,txt            setlocal noexpandtab

" turn off autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" quickly navigate buffers
nnoremap gb :ls<CR>:b<Space>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clojure Stuff

let s:CLOJURE_JAR = "C:\Users\noahz\.m2\repository\org\clojure\clojure\1.5.1\clojure-1.5.1.jar"
let s:TEMP_CLJ = "C:\Users\noahz\temp.clj"
" Paredit
let g:paredit_mode = 0

fun! CljCMD()
	execute 'w! '
	execute 'set syntax=clojure'
	execute 'ConqueTermSplit java -cp '.s:CLOJURE_JAR.' clojure.main /tmp/temp.clj'
endf
command! Clj call CljCMD()

"Kill ^M chars
fun! KMCMD() 
	execute '%s/\r$//g'
endf
command! Km call KMCMD()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby
autocmd FileType	ruby	setlocal makeprg=ruby\ %
autocmd FileType	ruby	let b:vimpipe_command="ruby"

fun! IrbCMD()
	execute 'ConqueTermSplit irb'
	execute 'set syntax=ruby'
endf
command! Irb call IrbCMD()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Scheme
colo desert
hi Pmenu guibg=brown gui=bold

" Further customization of colors is done with the AfterColors Plugin
" https://github.com/spf13/spf13-vim/blob/3.0/.vimrc 
" hi Pmenu guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
" hi PmenuSbar guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
" hi PmenuThumb guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE
" hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

set incsearch
set noeb vb t_vb=

set hidden
set number

" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks 
set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0
set formatoptions+=l

" Enable autoindent, cindent
" http://blogs.gnome.org/johannes/2006/11/10/getting-cool-auto-indent-in-vim/
set cindent
set smartindent
set autoindent

" Popup suggestions for the command buffer.
set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Customizing ins-completion / omni completion
" http://vim.wikia.com/wiki/Omni_completion 
" http://vim.wikia.com/wiki/Omni_completion_popup_menu 
" http://vim.wikia.com/wiki/Improve_completion_popup_menu
imap <C-space> <C-p>
set ofu=syntaxcomplete#Complete

inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rempap keys for window navigation
" http://vimcasts.org/episodes/working-with-windows/
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Saved macros - http://stackoverflow.com/questions/2024443/saving-vim-macros
let @c='bgUelguew' " Capitalize first leter and jump to next word.
let @v='"+gp'      " or maybe one day map Ctrl-Shift-P if possible?
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODOs
" http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
" http://www.faqs.org/docs/Linux-HOWTO/C-editing-with-VIM-HOWTO.html
" http://spf13.com/post/ultimate-vim-config 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://vim.wikia.com/wiki/Restore_screen_size_and_position 

if has("gui_running")
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return $HOME.'/.vimsize'
    endif
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif

" To enable the saving and restoring of screen positions.
let g:screen_size_restore_pos = 1

" To save and restore screen for each Vim instance.
" This is useful if you routinely run more than one Vim instance.
" For all Vim to use the same settings, change this to 0.
let g:screen_size_by_vim_instance = 1

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 13
  elseif has("gui_win32")
    set guifont=Consolas:h14:cANSI
  endif
endif

